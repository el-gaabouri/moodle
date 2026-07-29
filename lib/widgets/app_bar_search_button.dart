import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/assessment.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/models/navigation_args.dart';

class AppBarSearchButton extends StatelessWidget {
  const AppBarSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Search',
      icon: const Icon(Icons.search_outlined),
      onPressed: () {
        showSearch<void>(
          context: context,
          delegate: _MoodleSearchDelegate(),
        );
      },
    );
  }
}

class _MoodleSearchDelegate extends SearchDelegate<void> {
  _MoodleSearchDelegate()
      : super(
          searchFieldLabel: 'Search courses, resources, or activities',
        );

  final List<_MoodleSearchResult> _searchIndex = _buildSearchIndex();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear search',
          icon: const Icon(Icons.close),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Close search',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _SearchResultList(
      query: query,
      results: _filteredResults,
      onResultTap: (_MoodleSearchResult result) {
        _openResult(context, result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _SearchResultList(
      query: query,
      results: _filteredResults,
      onResultTap: (_MoodleSearchResult result) {
        _openResult(context, result);
      },
    );
  }

  List<_MoodleSearchResult> get _filteredResults {
    final String normalizedQuery = _normalize(query);
    final List<_MoodleSearchResult> results = _searchIndex.where((result) {
      return result.matches(normalizedQuery);
    }).toList();

    results.sort((_MoodleSearchResult a, _MoodleSearchResult b) {
      final int aScore = a.matchScore(normalizedQuery);
      final int bScore = b.matchScore(normalizedQuery);

      if (aScore != bScore) {
        return aScore.compareTo(bScore);
      }

      return a.title.compareTo(b.title);
    });

    return results;
  }

  void _openResult(BuildContext context, _MoodleSearchResult result) {
    final NavigatorState navigator = Navigator.of(context);
    close(context, null);
    navigator.pushNamed(result.routeName, arguments: result.arguments);
  }
}

class _SearchResultList extends StatelessWidget {
  const _SearchResultList({
    required this.query,
    required this.results,
    required this.onResultTap,
  });

  final String query;
  final List<_MoodleSearchResult> results;
  final ValueChanged<_MoodleSearchResult> onResultTap;

  @override
  Widget build(BuildContext context) {
    final bool hasQuery = query.trim().isNotEmpty;

    if (results.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'No matching courses, resources, or activities.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: moodleTextMuted),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1, thickness: 1, color: moodleBorder);
      },
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              hasQuery
                  ? '${results.length} search results'
                  : 'All searchable items',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: moodleTextMuted,
              ),
            ),
          );
        }

        final _MoodleSearchResult result = results[index - 1];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          leading: CircleAvatar(
            backgroundColor: moodleGrayBg,
            foregroundColor: moodlePurple,
            child: Icon(result.icon, size: 20),
          ),
          title: Text(
            result.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: moodleTextDark,
            ),
          ),
          subtitle: Text(
            result.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: moodleTextMuted),
          ),
          trailing: _SearchCategoryPill(category: result.category),
          onTap: () {
            onResultTap(result);
          },
        );
      },
    );
  }
}

class _SearchCategoryPill extends StatelessWidget {
  const _SearchCategoryPill({
    required this.category,
  });

  final _SearchCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: category.textColor,
        ),
      ),
    );
  }
}

class _MoodleSearchResult {
  const _MoodleSearchResult({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.routeName,
    required this.arguments,
    required this.searchText,
  });

  final String title;
  final String subtitle;
  final _SearchCategory category;
  final IconData icon;
  final String routeName;
  final Object arguments;
  final String searchText;

  bool matches(String normalizedQuery) {
    final List<String> queryTerms = _queryTerms(normalizedQuery);

    if (queryTerms.isEmpty) {
      return true;
    }

    return queryTerms.every(searchText.contains);
  }

  int matchScore(String normalizedQuery) {
    final List<String> queryTerms = _queryTerms(normalizedQuery);
    final String normalizedTitle = _normalize(title);
    final String normalizedSubtitle = _normalize(subtitle);

    if (queryTerms.isEmpty) {
      return category.sortOrder;
    }

    if (_normalize(title).startsWith(normalizedQuery)) {
      return 0;
    }

    if (_normalize(subtitle).startsWith(normalizedQuery)) {
      return 1;
    }

    if (queryTerms.every(normalizedTitle.contains)) {
      return 2;
    }

    if (queryTerms.every(normalizedSubtitle.contains)) {
      return 3;
    }

    return 4 + category.sortOrder;
  }
}

enum _SearchCategory {
  course,
  resource,
  activity,
}

extension _SearchCategoryDetails on _SearchCategory {
  String get label {
    switch (this) {
      case _SearchCategory.course:
        return 'Course';
      case _SearchCategory.resource:
        return 'Resource';
      case _SearchCategory.activity:
        return 'Activity';
    }
  }

  int get sortOrder {
    switch (this) {
      case _SearchCategory.course:
        return 0;
      case _SearchCategory.resource:
        return 1;
      case _SearchCategory.activity:
        return 2;
    }
  }

  Color get textColor {
    switch (this) {
      case _SearchCategory.course:
        return moodlePurple;
      case _SearchCategory.resource:
        return moodleBlue;
      case _SearchCategory.activity:
        return const Color(0xFF067647);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case _SearchCategory.course:
        return const Color(0xFFF3EAF4);
      case _SearchCategory.resource:
        return const Color(0xFFEAF3FF);
      case _SearchCategory.activity:
        return const Color(0xFFE7F6EC);
    }
  }
}

List<_MoodleSearchResult> _buildSearchIndex() {
  final List<_MoodleSearchResult> results = [];

  for (final Course course in courses) {
    results.add(
      _MoodleSearchResult(
        title: course.name,
        subtitle: '${course.module} - ${course.department}',
        category: _SearchCategory.course,
        icon: Icons.school_outlined,
        routeName: '/course-details',
        arguments: CourseDetailsArguments(course: course),
        searchText: _normalize(
          '${course.name} ${course.module} ${course.department}',
        ),
      ),
    );

    for (final CourseResource resource in course.details.resources) {
      results.add(
        _MoodleSearchResult(
          title: resource.label,
          subtitle: '${course.module} - ${course.name}',
          category: _SearchCategory.resource,
          icon: _iconForCourseResource(resource.type),
          routeName: '/course-details',
          arguments: CourseDetailsArguments(course: course),
          searchText: _normalize(
            '${resource.label} ${course.name} ${course.module} ${course.department}',
          ),
        ),
      );
    }

    results.add(
      _MoodleSearchResult(
        title: course.details.readingLists.title,
        subtitle: '${course.module} - ${course.name}',
        category: _SearchCategory.resource,
        icon: Icons.menu_book_outlined,
        routeName: '/course-details',
        arguments: CourseDetailsArguments(course: course, initialSection: 2),
        searchText: _normalize(
          '${course.details.readingLists.title} ${course.details.readingLists.description} ${course.name} ${course.module}',
        ),
      ),
    );

    results.add(
      _MoodleSearchResult(
        title: course.details.referral.title,
        subtitle: '${course.module} - ${course.name}',
        category: _SearchCategory.activity,
        icon: Icons.assignment_outlined,
        routeName: '/course-details',
        arguments: CourseDetailsArguments(course: course),
        searchText: _normalize(
          '${course.details.referral.title} ${course.details.referral.description} ${course.details.referral.briefLinkLabel ?? ''} ${course.name} ${course.module}',
        ),
      ),
    );
  }

  for (final Assessment assessment in assessments) {
    results.add(
      _MoodleSearchResult(
        title: assessment.title,
        subtitle:
            '${formatAssessmentDate(assessment.dueDate)} - ${assessment.moduleName}',
        category: _SearchCategory.activity,
        icon: Icons.assignment_outlined,
        routeName: '/assignment',
        arguments: AssignmentArguments(assessment: assessment),
        searchText: _normalize(
          '${assessment.title} ${assessment.moduleName} ${formatAssessmentDate(assessment.dueDate)} ${assessment.status.label}',
        ),
      ),
    );
  }

  return results;
}

IconData _iconForCourseResource(CourseResourceType type) {
  switch (type) {
    case CourseResourceType.announcements:
      return Icons.chat_bubble_outline;
    case CourseResourceType.folder:
      return Icons.folder_open_outlined;
  }
}

String _normalize(String value) {
  return value.trim().toLowerCase();
}

List<String> _queryTerms(String normalizedQuery) {
  return normalizedQuery
      .split(RegExp(r'\s+'))
      .where((String term) => term.isNotEmpty)
      .toList();
}
