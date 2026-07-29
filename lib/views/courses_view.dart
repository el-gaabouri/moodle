import 'package:flutter/material.dart';
import 'package:moodle/widgets/account_menu_button.dart';
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

class _CourseDetailsView extends StatelessWidget {
  const _CourseDetailsView({required this.course});

  final _Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: moodleWhite,
        foregroundColor: moodleTextDark,
        elevation: 1,
        title: const Text(
          'Course details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      backgroundColor: moodleBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
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
                Text(
                  course.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: moodlePurple,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1, color: moodleBorder),
                const SizedBox(height: 20),
                const Text(
                  'Module',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: moodleTextDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course.module,
                  style: const TextStyle(fontSize: 14, color: moodleTextMuted),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Department',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: moodleTextDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course.department,
                  style: const TextStyle(fontSize: 14, color: moodleTextMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
