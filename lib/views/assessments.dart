import 'package:flutter/material.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class AssessmentsView extends StatelessWidget {
  const AssessmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'My Assessments',
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'My Assessments',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Upcoming assessments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            SizedBox(height: 12),
            _AssessmentCard(
              title: 'Mobile application prototype',
              dueDate: '14 August 2026',
              status: 'Not yet submitted',
              statusColor: moodlePurple,
              statusBackgroundColor: Color(0xFFF3EAF4),
            ),
            SizedBox(height: 12),
            _AssessmentCard(
              title: 'Database design report',
              dueDate: '21 August 2026',
              status: 'Not available',
              statusColor: moodleTextMuted,
              statusBackgroundColor: moodleGrayBg,
            ),
            SizedBox(height: 24),
            Text(
              'Past assessments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            SizedBox(height: 12),
            _AssessmentCard(
              title: 'Web development coursework',
              dueDate: '10 July 2026',
              status: 'Overdue',
              statusColor: Color(0xFFB42318),
              statusBackgroundColor: Color(0xFFFDECEC),
            ),
            SizedBox(height: 12),
            _AssessmentCard(
              title: 'Research methods presentation',
              dueDate: '26 June 2026',
              status: 'Submitted',
              statusColor: Color(0xFF067647),
              statusBackgroundColor: Color(0xFFE7F6EC),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AssessmentCard extends StatelessWidget {
  const _AssessmentCard({
    required this.title,
    required this.dueDate,
    required this.status,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String title;
  final String dueDate;
  final String status;
  final Color statusColor;
  final Color statusBackgroundColor;

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
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: moodleTextDark,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Due date: $dueDate',
                  style: const TextStyle(fontSize: 14, color: moodleTextMuted),
                ),
                _StatusBadge(
                  label: status,
                  textColor: statusColor,
                  backgroundColor: statusBackgroundColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
  });

  final String label;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
