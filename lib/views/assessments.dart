import 'package:flutter/material.dart';
import 'package:moodle/models/assessment.dart';
import 'package:moodle/views/assignment_view.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
import 'package:moodle/widgets/app_bar_search_button.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class AssessmentsView extends StatelessWidget {
  const AssessmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Assessment> upcomingAssessments = assessmentsForSection(
      AssessmentSection.upcoming,
    );
    final List<Assessment> pastAssessments = assessmentsForSection(
      AssessmentSection.past,
    );

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
              const AppBarNavLinks(),
            ],
          ),
        ),
        actions: [
          const AppBarSearchButton(),
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
              'My Assessments',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            const SizedBox(height: 24),
            _AssessmentSection(
              title: 'Upcoming assessments',
              assessments: upcomingAssessments,
            ),
            const SizedBox(height: 24),
            _AssessmentSection(
              title: 'Past assessments',
              assessments: pastAssessments,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AssessmentSection extends StatelessWidget {
  const _AssessmentSection({
    required this.title,
    required this.assessments,
  });

  final String title;
  final List<Assessment> assessments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const SizedBox(height: 12),
        for (int index = 0; index < assessments.length; index++) ...[
          _AssessmentCard(assessment: assessments[index]),
          if (index < assessments.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _AssessmentCard extends StatelessWidget {
  const _AssessmentCard({
    required this.assessment,
  });

  final Assessment assessment;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: moodleBorder),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    assessment.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: moodleTextDark,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _StatusBadge(
                  status: assessment.status,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              assessment.moduleName,
              style: const TextStyle(fontSize: 14, color: moodleTextMuted),
            ),
            const SizedBox(height: 8),
            Text(
              'Due date: ${formatAssessmentDate(assessment.dueDate)}',
              style: const TextStyle(fontSize: 14, color: moodleTextMuted),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return AssignmentView(assessment: assessment);
                      },
                    ),
                  );
                },
                child: const Text('Go to assignment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final AssessmentStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: status.textColor,
        ),
      ),
    );
  }
}

extension _AssessmentStatusColors on AssessmentStatus {
  Color get textColor {
    switch (this) {
      case AssessmentStatus.notYetSubmitted:
        return moodlePurple;
      case AssessmentStatus.notAvailable:
        return moodleTextMuted;
      case AssessmentStatus.overdue:
        return const Color(0xFFB42318);
      case AssessmentStatus.submitted:
        return const Color(0xFF067647);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case AssessmentStatus.notYetSubmitted:
        return const Color(0xFFF3EAF4);
      case AssessmentStatus.notAvailable:
        return moodleGrayBg;
      case AssessmentStatus.overdue:
        return const Color(0xFFFDECEC);
      case AssessmentStatus.submitted:
        return const Color(0xFFE7F6EC);
    }
  }
}
