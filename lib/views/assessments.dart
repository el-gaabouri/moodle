import 'package:flutter/material.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
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
              title:
                  'Item 1 (Flutter) - Referral and Deferral Coursework. Deadline: 29/07/2026 13:00pm (with the 48 hour extension: 31/07/2026 13:00pm)',
              dueDate: '29 July 2026',
              moduleName:
                  'M30235 - Programming Applications and Programming Languages (2025/26)',
              status: 'Not yet submitted',
              statusColor: moodlePurple,
              statusBackgroundColor: Color(0xFFF3EAF4),
            ),
            SizedBox(height: 12),
            _AssessmentCard(
              title:
                  'Ref/Def - Item 2 M30235 - Computer Based Exam (30 July 2026, 10:00 AM)',
              dueDate: '30 July 2026',
              moduleName:
                  'M30235 - Programming Applications and Programming Languages (2025/26)',
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
              title: 'Referral/Deferral Functional Programming Assessment',
              dueDate: '10 July 2026',
              moduleName:
                  'M21274-2025/26-SMJAN: Discrete Mathematics And Functional Programming (MATHFUN) (2025/26)',
              status: 'Overdue',
              statusColor: Color(0xFFB42318),
              statusBackgroundColor: Color(0xFFFDECEC),
            ),
            SizedBox(height: 12),
            _AssessmentCard(
              title:
                  'Item 2 - Coursework - EC/late (Due Date: 28.5.2026 13:00pm)',
              dueDate: '26 June 2026',
              moduleName:
                  'M30819-2025/26-SMYEAR: Software Engineering Theory and Practice (2025/26)',
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
    required this.moduleName,
    required this.status,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String title;
  final String dueDate;
  final String status;
  final String moduleName;
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: moodleTextDark,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _StatusBadge(
                  label: status,
                  textColor: statusColor,
                  backgroundColor: statusBackgroundColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              moduleName,
              style: const TextStyle(fontSize: 14, color: moodleTextMuted),
            ),
            const SizedBox(height: 8),
            Text(
              'Due date: $dueDate',
              style: const TextStyle(fontSize: 14, color: moodleTextMuted),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {},
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
