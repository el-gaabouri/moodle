import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/assessment.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
import 'package:moodle/widgets/nav_drawer.dart';

class AssignmentView extends StatelessWidget {
  const AssignmentView({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  final Assessment assessment;

  @override
  Widget build(BuildContext context) {
    final AssignmentSubmissionDetails details = assessment.assignmentDetails;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              assessment.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              assessment.moduleName,
              style: const TextStyle(fontSize: 14, color: moodleTextMuted),
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
                    Text(
                      details.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: moodlePurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: moodleBorder,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      details.statusHeading,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SubmissionStatusTable(rows: details.rows),
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

class _SubmissionStatusTable extends StatelessWidget {
  const _SubmissionStatusTable({
    required this.rows,
  });

  final List<AssignmentSubmissionRow> rows;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: moodleBorder),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(0.36),
        1: FlexColumnWidth(0.64),
      },
      children: rows.map((AssignmentSubmissionRow row) {
        return TableRow(
          children: [
            _SubmissionTableCell(
              text: row.label,
              backgroundColor: moodleSurface,
              bold: true,
            ),
            _SubmissionTableCell(text: row.value),
          ],
        );
      }).toList(),
    );
  }
}

class _SubmissionTableCell extends StatelessWidget {
  const _SubmissionTableCell({
    required this.text,
    this.backgroundColor,
    this.bold = false,
  });

  final String text;
  final Color? backgroundColor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: moodleTextDark,
        ),
      ),
    );
  }
}
