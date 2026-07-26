import 'package:flutter/material.dart';
import 'package:moodle/views/dashboard_view.dart';
import 'package:moodle/views/courses_view.dart';
import 'package:moodle/views/assessments.dart';
import 'package:moodle/views/calendar.dart';
import 'package:moodle/views/help_support.dart';
import 'package:moodle/views/profile.dart';
import 'package:moodle/views/useful_links.dart';
import 'package:moodle/views/login.dart';
import 'package:moodle/constants.dart';

void main() {
  runApp(const MoodleApp());
}

class MoodleApp extends StatelessWidget {
  const MoodleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodle',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: moodlePurple,
          primary: moodlePurple,
          secondary: moodleSecondary,
          surface: moodleSurface,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardView(),
        '/courses': (context) => const CoursesView(),
        '/assessments': (context) => const AssessmentsView(),
        '/calendar': (context) => const CalendarView(),
        '/help_support': (context) => const HelpSupportView(),
        '/profile': (context) => const ProfileView(),
        '/useful_links': (context) => const UsefulLinksView(),
        '/login': (context) => const LoginView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
