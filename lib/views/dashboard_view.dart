import 'package:flutter/material.dart';
import 'package:moodle/views/calendar.dart' show CalendarCard;
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

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
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            SizedBox(height: 24),
            _DashboardCard(
              title: 'Timeline',
              child: Column(
                children: [
                  _TimelineRow(
                    date: '30 July 2026',
                    assessment: 'Ref/Def - Item 2 M30235 - Computer Based Exam',
                  ),
                  Divider(height: 24, thickness: 1, color: moodleBorder),
                  _TimelineRow(
                    date: '29 July 2026',
                    assessment:
                        'Item 1 (Flutter) - Referral and Deferral Coursework',
                  ),
                  Divider(height: 24, thickness: 1, color: moodleBorder),
                  _TimelineRow(
                    date: '10 July 2026',
                    assessment:
                        'Referral/Deferral Functional Programming Assessment',
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _DashboardCard(
              title: 'Latest announcements',
              child: Text(
                '(No announcements have been posted yet.)',
                style: TextStyle(fontSize: 14, color: moodleTextMuted),
              ),
            ),
            SizedBox(height: 24),
            _DashboardCard(
              child: CalendarCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    this.title,
    required this.child,
  });

  final String? title;
  final Widget child;

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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, thickness: 1, color: moodleBorder),
              const SizedBox(height: 20),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.date,
    required this.assessment,
  });

  final String date;
  final String assessment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112,
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: moodleTextDark,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            assessment,
            style: const TextStyle(fontSize: 14, color: moodleTextMuted),
          ),
        ),
      ],
    );
  }
}
