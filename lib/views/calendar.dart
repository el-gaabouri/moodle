import 'package:flutter/material.dart';
import 'package:moodle/widgets/account_menu_button.dart';
import 'package:moodle/widgets/app_bar_nav_links.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

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
              'Calendar',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            SizedBox(height: 24),
            Card(
              color: moodleWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: moodleBorder),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CalendarCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarCard extends StatefulWidget {
  const CalendarCard({Key? key}) : super(key: key);

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  late final DateTime today;
  late DateTime visibleMonth;
  DateTime? selectedDate;

  static final List<_CalendarAssessment> assessments = [
    _CalendarAssessment(
      title:
          'Item 1 (Flutter) - Referral and Deferral Coursework. Deadline: 29/07/2026 13:00pm (with the 48 hour extension: 31/07/2026 13:00pm)',
      moduleName:
          'M30235 - Programming Applications and Programming Languages (2025/26)',
      status: 'Not yet submitted',
      date: DateTime(2026, 7, 29),
      statusColor: moodlePurple,
      statusBackgroundColor: const Color(0xFFF3EAF4),
    ),
    _CalendarAssessment(
      title:
          'Ref/Def - Item 2 M30235 - Computer Based Exam (30 July 2026, 10:00 AM)',
      moduleName:
          'M30235 - Programming Applications and Programming Languages (2025/26)',
      status: 'Not available',
      date: DateTime(2026, 7, 30),
      statusColor: moodleTextMuted,
      statusBackgroundColor: moodleGrayBg,
    ),
    _CalendarAssessment(
      title: 'Referral/Deferral Functional Programming Assessment',
      moduleName:
          'M21274-2025/26-SMJAN: Discrete Mathematics And Functional Programming (MATHFUN) (2025/26)',
      status: 'Overdue',
      date: DateTime(2026, 7, 10),
      statusColor: const Color(0xFFB42318),
      statusBackgroundColor: const Color(0xFFFDECEC),
    ),
    _CalendarAssessment(
      title: 'Item 2 - Coursework - EC/late (Due Date: 28.5.2026 13:00pm)',
      moduleName:
          'M30819-2025/26-SMYEAR: Software Engineering Theory and Practice (2025/26)',
      status: 'Submitted',
      date: DateTime(2026, 6, 26),
      statusColor: const Color(0xFF067647),
      statusBackgroundColor: const Color(0xFFE7F6EC),
    ),
  ];

  static const List<String> weekdayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    visibleMonth = DateTime(today.year, today.month);
  }

  void showPreviousMonth() {
    setState(() {
      visibleMonth = DateTime(visibleMonth.year, visibleMonth.month - 1);
    });
  }

  void showNextMonth() {
    setState(() {
      visibleMonth = DateTime(visibleMonth.year, visibleMonth.month + 1);
    });
  }

  void showCurrentMonth() {
    setState(() {
      visibleMonth = DateTime(today.year, today.month);
    });
  }

  void selectDay(int day) {
    final DateTime date = DateTime(visibleMonth.year, visibleMonth.month, day);
    final List<_CalendarAssessment> dayAssessments = assessmentsForDate(date);

    setState(() {
      selectedDate = date;
    });

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('${monthName(date.month)} ${date.day}, ${date.year}'),
          content: _CalendarDayDialogContent(
            assessments: dayAssessments,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<_CalendarAssessment> assessmentsForDate(DateTime date) {
    return assessments.where((assessment) {
      return assessment.date.year == date.year &&
          assessment.date.month == date.month &&
          assessment.date.day == date.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime firstDayOfMonth = DateTime(
      visibleMonth.year,
      visibleMonth.month,
    );
    final int daysInMonth = DateTime(
      visibleMonth.year,
      visibleMonth.month + 1,
      0,
    ).day;
    final int leadingEmptyDays = firstDayOfMonth.weekday - 1;
    final int totalCells = leadingEmptyDays + daysInMonth <= 35 ? 35 : 42;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calendar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: moodlePurple,
          ),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, thickness: 1, color: moodleBorder),
        const SizedBox(height: 20),
        Row(
          children: [
            IconButton(
              tooltip: 'Previous month',
              icon: const Icon(Icons.chevron_left),
              color: moodlePurple,
              onPressed: showPreviousMonth,
            ),
            Expanded(
              child: Text(
                '${monthName(visibleMonth.month)} ${visibleMonth.year}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: moodlePurple,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Next month',
              icon: const Icon(Icons.chevron_right),
              color: moodlePurple,
              onPressed: showNextMonth,
            ),
            TextButton(
              onPressed: showCurrentMonth,
              child: const Text(
                'Today',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: weekdayLabels
              .map(
                (String label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: moodleTextMuted,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool showAssessmentLabels = constraints.maxWidth >= 520;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalCells,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: constraints.maxWidth > 520 ? 1.5 : 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                final int day = index - leadingEmptyDays + 1;

                if (day < 1 || day > daysInMonth) {
                  return const SizedBox.shrink();
                }

                final bool isToday = day == today.day &&
                    visibleMonth.month == today.month &&
                    visibleMonth.year == today.year;
                final bool isSelected = selectedDate != null &&
                    day == selectedDate!.day &&
                    visibleMonth.month == selectedDate!.month &&
                    visibleMonth.year == selectedDate!.year;
                final List<_CalendarAssessment> dayAssessments =
                    assessmentsForDate(
                  DateTime(visibleMonth.year, visibleMonth.month, day),
                );

                return _CalendarDayCell(
                  day: day,
                  isToday: isToday,
                  isSelected: isSelected,
                  assessments: dayAssessments,
                  showAssessmentLabels: showAssessmentLabels,
                  onTap: () {
                    selectDay(day);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  String monthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}

class _CalendarAssessment {
  const _CalendarAssessment({
    required this.title,
    required this.moduleName,
    required this.status,
    required this.date,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String title;
  final String moduleName;
  final String status;
  final DateTime date;
  final Color statusColor;
  final Color statusBackgroundColor;
}

class _CalendarDayDialogContent extends StatelessWidget {
  const _CalendarDayDialogContent({
    required this.assessments,
  });

  final List<_CalendarAssessment> assessments;

  @override
  Widget build(BuildContext context) {
    if (assessments.isEmpty) {
      return const Text(
        'No assessments on this date.',
        style: TextStyle(fontSize: 14, color: moodleTextMuted),
      );
    }

    return SizedBox(
      width: 420,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: assessments
            .map(
              (assessment) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _CalendarAssessmentSummary(
                  assessment: assessment,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CalendarAssessmentSummary extends StatelessWidget {
  const _CalendarAssessmentSummary({
    required this.assessment,
  });

  final _CalendarAssessment assessment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: moodleBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            assessment.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: moodleTextDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            assessment.moduleName,
            style: const TextStyle(fontSize: 13, color: moodleTextMuted),
          ),
          const SizedBox(height: 10),
          _CalendarStatusBadge(
            label: assessment.status,
            textColor: assessment.statusColor,
            backgroundColor: assessment.statusBackgroundColor,
          ),
        ],
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    Key? key,
    required this.day,
    required this.isToday,
    required this.isSelected,
    required this.assessments,
    required this.showAssessmentLabels,
    required this.onTap,
  }) : super(key: key);

  final int day;
  final bool isToday;
  final bool isSelected;
  final List<_CalendarAssessment> assessments;
  final bool showAssessmentLabels;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isSelected
        ? moodlePurple
        : isToday
            ? moodleGrayBg
            : moodleSurface;
    final Color borderColor =
        isSelected || isToday ? moodlePurple : moodleBorder;
    final Color textColor = isSelected
        ? moodleWhite
        : isToday
            ? moodlePurple
            : moodleTextDark;
    final TextStyle dayTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
      color: textColor,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: !showAssessmentLabels && assessments.isNotEmpty
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('$day', style: dayTextStyle),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: _CalendarAssessmentDots(
                        count: assessments.length,
                        selected: isSelected,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$day', style: dayTextStyle),
                    if (assessments.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final _CalendarAssessment assessment
                                in assessments.take(2))
                              _CalendarAssessmentChip(
                                assessment: assessment,
                                selected: isSelected,
                              ),
                            if (assessments.length > 2)
                              Text(
                                '+${assessments.length - 2} more',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected
                                      ? moodleWhite
                                      : moodleTextMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}

class _CalendarAssessmentDots extends StatelessWidget {
  const _CalendarAssessmentDots({
    required this.count,
    required this.selected,
  });

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3,
      runSpacing: 3,
      children: List<Widget>.generate(
        count > 3 ? 3 : count,
        (int index) => Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: selected ? moodleWhite : moodlePurple,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _CalendarAssessmentChip extends StatelessWidget {
  const _CalendarAssessmentChip({
    required this.assessment,
    required this.selected,
  });

  final _CalendarAssessment assessment;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0x2EFFFFFF)
            : assessment.statusBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        assessment.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: selected ? moodleWhite : assessment.statusColor,
        ),
      ),
    );
  }
}

class _CalendarStatusBadge extends StatelessWidget {
  const _CalendarStatusBadge({
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
