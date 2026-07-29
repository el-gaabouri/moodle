import 'package:flutter/material.dart';
import 'package:moodle/utils/asset_link_opener.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<_Course> courses = [
      _Course(
        name: 'Programming Applications and Programming Languages',
        module: 'M30235',
        department: 'School of Computing',
      ),
      _Course(
        name: 'Discrete Mathematics And Functional Programming',
        module: 'M21274',
        department: 'School of Mathematics and Physics',
      ),
      _Course(
        name: 'Software Engineering Theory and Practice',
        module: 'M30819',
        department: 'School of Computing',
      ),
      _Course(
        name: 'Database Systems',
        module: 'M30234',
        department: 'School of Computing',
      ),
      _Course(
        name: 'Web Foundations',
        module: 'M30229',
        department: 'School of Computing',
      ),
      _Course(
        name: 'Computer Networks',
        module: 'M30231',
        department: 'School of Computing',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: moodleWhite,
        foregroundColor: moodleTextDark,
        elevation: 1,
        titleSpacing: 0,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 32,
                height: 32,
                child: Image.asset(
                  'images/moodle_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'My courses',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 24),
              const AppBarNavLinks(),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const AccountMenuButton(),
          const SizedBox(width: 16),
        ],
      ),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'My courses',
              style: TextStyle(
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
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Course overview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: moodlePurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, thickness: 1, color: moodleBorder),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        final double width = constraints.maxWidth;
                        final int crossAxisCount = width >= 900
                            ? 3
                            : width >= 620
                                ? 2
                                : 1;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: courses.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.12,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final _Course course = courses[index];

                            return _CourseCard(
                              course: course,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return _CourseDetailsView(course: course);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Course {
  const _Course({
    required this.name,
    required this.module,
    required this.department,
  });

  final String name;
  final String module;
  final String department;
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.onTap,
  });

  final _Course course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: moodleWhite,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'images/course.png',
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                course.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course.module,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: moodleTextDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                course.department,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: moodleTextMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseDetailsView extends StatefulWidget {
  const _CourseDetailsView({required this.course});

  final _Course course;

  @override
  State<_CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<_CourseDetailsView> {
  int selectedSection = 0;

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
        title: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                'Course details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(width: 24),
              AppBarNavLinks(),
            ],
          ),
        ),
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
  final _Course course;

  @override
  Widget build(BuildContext context) {
    if (sectionIndex == 1) {
      return _ModuleInfoSection(course: course);
    }

    if (sectionIndex == 2) {
      return const _ReadingListsSection();
    }

    return _CourseSection(course: course);
  }
}

class _CourseSection extends StatelessWidget {
  const _CourseSection({required this.course});

  final _Course course;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'General',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: moodleTextDark,
          ),
        ),
        const SizedBox(height: 20),
        const _CourseResourceRow(
          icon: Icons.chat_bubble_outline,
          label: 'Announcements',
        ),
        const Divider(height: 32, thickness: 1, color: moodleBorder),
        _CourseResourceRow(
          icon: Icons.folder_open_outlined,
          label: '${course.module} course materials',
        ),
        const Divider(height: 32, thickness: 1, color: moodleBorder),
        const Text(
          'Referral and Deferral Assessments',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const SizedBox(height: 12),
        if (course.module == 'M30235')
          _ProgrammingApplicationsReferralInfo(
            onOpenBrief: () {
              final bool opened = openAssetPath(
                'images/flutter_ref_def_coursework.pdf',
              );

              if (!opened) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'The coursework brief is available at images/flutter_ref_def_coursework.pdf',
                    ),
                  ),
                );
              }
            },
          )
        else
          const Text(
            'Assessment and support information for referral and deferral work will appear here.',
            style: TextStyle(fontSize: 14, color: moodleTextDark),
          ),
      ],
    );
  }
}

class _ProgrammingApplicationsReferralInfo extends StatelessWidget {
  const _ProgrammingApplicationsReferralInfo({
    required this.onOpenBrief,
  });

  final VoidCallback onOpenBrief;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'The coursework brief can be accessed via this link: ',
              style: TextStyle(fontSize: 14, color: moodleTextDark),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: onOpenBrief,
              child: const Text('Flutter Referral and Deferral Coursework.pdf'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Paste the link to the GitHub repository for your coursework in the provided text field of the submission page and click on Save changes. You are not submitting any files for this coursework. You should have forked this repository and built upon it as instructed in the brief. This way, the submitted link should be of this format (where YOUR-USERNAME is replaced with your GitHub username):\n\n'
          'https://github.com/YOUR-USERNAME/moodle\n\n'
          'Make sure the repository is public. Check to see if it opens in an incognito/private window (you should not get a 404 error).\n\n'
          '\u26A0\uFE0F Do not make any commits after the deadline. I will label your submission as late if you do this.',
          style: TextStyle(fontSize: 14, color: moodleTextDark, height: 1.45),
        ),
      ],
    );
  }
}

class _ModuleInfoSection extends StatelessWidget {
  const _ModuleInfoSection({required this.course});

  final _Course course;

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
        _InfoLine(label: 'Module', value: course.module),
        const SizedBox(height: 16),
        _InfoLine(label: 'Department', value: course.department),
        const SizedBox(height: 16),
        _InfoLine(label: 'Course name', value: course.name),
      ],
    );
  }
}

class _ReadingListsSection extends StatelessWidget {
  const _ReadingListsSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reading Lists',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Reading list links and course resources will appear here.',
          style: TextStyle(fontSize: 14, color: moodleTextMuted),
        ),
      ],
    );
  }
}

class _CourseResourceRow extends StatelessWidget {
  const _CourseResourceRow({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: moodleBlue, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: moodleBlue),
          ),
        ),
      ],
    );
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
