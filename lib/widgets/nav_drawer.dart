import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    final bool isDashboard = currentRoute == '/';
    final bool isCourses = currentRoute == '/courses';
    final bool isCalendar = currentRoute == '/calendar';
    final bool isAssessments = currentRoute == '/assessments';

    return Drawer(
      backgroundColor: moodlePurple,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 176,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: moodleDarkPurple,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: moodleWhite,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: moodlePurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Anass El Gaabouri',
                        style: TextStyle(
                          color: moodleWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'up2268566@myport.ac.uk',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Dashboard',
                style: TextStyle(color: moodleWhite, fontSize: 16),
              ),
              selected: isDashboard,
              selectedTileColor: Colors.white24,
              onTap: () {
                Navigator.pop(context);
                if (!isDashboard) {
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
            ),
            ListTile(
              title: const Text(
                'My Assessments',
                style: TextStyle(color: moodleWhite, fontSize: 16),
              ),
              selected: isAssessments,
              selectedTileColor: Colors.white24,
              onTap: () {
                Navigator.pop(context);
                if (!isAssessments) {
                  Navigator.pushReplacementNamed(context, '/assessments');
                }
              },
            ),
            ListTile(
              title: const Text(
                'Calendar',
                style: TextStyle(color: moodleWhite, fontSize: 16),
              ),
              selected: isCalendar,
              selectedTileColor: Colors.white24,
              onTap: () {
                Navigator.pop(context);
                if (!isCalendar) {
                  Navigator.pushReplacementNamed(context, '/calendar');
                }
              },
            ),
            ListTile(
              title: const Text(
                'My courses',
                style: TextStyle(color: moodleWhite, fontSize: 16),
              ),
              selected: isCourses,
              selectedTileColor: Colors.white24,
              onTap: () {
                Navigator.pop(context);
                if (!isCourses) {
                  Navigator.pushReplacementNamed(context, '/courses');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
