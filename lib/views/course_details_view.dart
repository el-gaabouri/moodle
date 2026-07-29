import 'package:flutter/material.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/utils/asset_link_opener.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
import 'package:moodle/widgets/app_bar_search_button.dart';
import 'package:moodle/constants.dart';

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({
    Key? key,
    required this.course,
    this.initialSection = 0,
  }) : super(key: key);

  final Course course;
  final int initialSection;

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  late int selectedSection;

  @override
  void initState() {
    super.initState();
    selectedSection = widget.initialSection;
  }

  void selectSection(int index) {
    setState(() {
      selectedSection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: moodleWhite,
        foregroundColor: moodleTextDark,
        elevation: 1,
        titleSpacing: 0,
        title: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Course details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              AppBarNavLinks(),
            ],
          ),
        ),
        actions: const [
          AppBarSearchButton(),
          SizedBox(width: 8),
          AccountMenuButton(),
          SizedBox(width: 16),
        ],
      ),
      backgroundColor: moodleBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.course.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: moodleWhite,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: moodleBorder),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _CourseSectionTab(
                          label: 'Course',
                          selected: selectedSection == 0,
                          onTap: () {
                            selectSection(0);
                          },
                        ),
                        _CourseSectionTab(
                          label: 'Module Info',
                          selected: selectedSection == 1,
                          onTap: () {
                            selectSection(1);
                          },
                        ),
                        _CourseSectionTab(
                          label: 'Reading Lists',
                          selected: selectedSection == 2,
                          onTap: () {
                            selectSection(2);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 1, color: moodleBorder),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _CourseSectionContent(
                      sectionIndex: selectedSection,
                      course: widget.course,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseSectionTab extends StatelessWidget {
  const _CourseSectionTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? moodleBlue : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: selected ? moodleTextDark : moodleBlue,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _CourseSectionContent extends StatelessWidget {
  const _CourseSectionContent({
    required this.sectionIndex,
    required this.course,
  });

  final int sectionIndex;
  final Course course;

  @override
  Widget build(BuildContext context) {
    if (sectionIndex == 1) {
      return _ModuleInfoSection(course: course);
    }

    if (sectionIndex == 2) {
      return _ReadingListsSection(readingLists: course.details.readingLists);
    }

    return _CourseSection(course: course);
  }
}

class _CourseSection extends StatelessWidget {
  const _CourseSection({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.details.generalTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: moodleTextDark,
          ),
        ),
        const SizedBox(height: 20),
        for (final CourseResource resource in course.details.resources) ...[
          _CourseResourceRow(resource: resource),
          const Divider(height: 32, thickness: 1, color: moodleBorder),
        ],
        Text(
          course.details.referral.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const SizedBox(height: 12),
        _ReferralInfo(
          referral: course.details.referral,
          onOpenBrief: course.details.referral.briefAssetPath == null
              ? null
              : () {
                  final String assetPath =
                      course.details.referral.briefAssetPath!;
                  final bool opened = openAssetPath(assetPath);

                  if (!opened) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'The coursework brief is available at $assetPath',
                        ),
                      ),
                    );
                  }
                },
        ),
      ],
    );
  }
}

class _ReferralInfo extends StatelessWidget {
  const _ReferralInfo({
    required this.referral,
    this.onOpenBrief,
  });

  final ReferralDetails referral;
  final VoidCallback? onOpenBrief;

  @override
  Widget build(BuildContext context) {
    final bool hasBriefLink =
        referral.briefIntro != null && referral.briefLinkLabel != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasBriefLink) ...[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                referral.briefIntro!,
                style: const TextStyle(fontSize: 14, color: moodleTextDark),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: onOpenBrief,
                child: Text(referral.briefLinkLabel!),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (referral.description.isNotEmpty)
          Text(
            referral.description,
            style: const TextStyle(fontSize: 14, color: moodleTextDark),
          ),
        if (referral.instructions != null)
          Text(
            referral.instructions!,
            style: const TextStyle(
              fontSize: 14,
              color: moodleTextDark,
              height: 1.45,
            ),
          ),
      ],
    );
  }
}

class _ModuleInfoSection extends StatelessWidget {
  const _ModuleInfoSection({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Module Info',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const SizedBox(height: 20),
        for (final CourseInfoItem item in course.details.moduleInfo) ...[
          _InfoLine(label: item.label, value: item.value),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _ReadingListsSection extends StatelessWidget {
  const _ReadingListsSection({
    required this.readingLists,
  });

  final ReadingListsDetails readingLists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          readingLists.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          readingLists.description,
          style: const TextStyle(fontSize: 14, color: moodleTextMuted),
        ),
      ],
    );
  }
}

class _CourseResourceRow extends StatelessWidget {
  const _CourseResourceRow({
    required this.resource,
  });

  final CourseResource resource;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_iconForResource(resource.type), color: moodleBlue, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            resource.label,
            style: const TextStyle(fontSize: 16, color: moodleBlue),
          ),
        ),
      ],
    );
  }

  IconData _iconForResource(CourseResourceType type) {
    switch (type) {
      case CourseResourceType.announcements:
        return Icons.chat_bubble_outline;
      case CourseResourceType.folder:
        return Icons.folder_open_outlined;
    }
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: moodleTextDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: moodleTextMuted),
        ),
      ],
    );
  }
}
