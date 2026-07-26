import 'package:flutter/material.dart';
import 'package:moodle/widgets/account_menu_button.dart';
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
              const Text(
                'My Calendar',
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
  State<CalendarCard> createState() => CalendarCardState();
}

class CalendarCardState extends State<CalendarCard> {
  late final DateTime today;
  late DateTime visibleMonth;
  DateTime? selectedDate;

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

    setState(() {
      selectedDate = date;
    });

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Selected day'),
          content: Text('${monthName(date.month)} ${date.day}, ${date.year}'),
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

                return CalendarDayCell(
                  day: day,
                  isToday: isToday,
                  isSelected: isSelected,
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

class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    Key? key,
    required this.day,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final int day;
  final bool isToday;
  final bool isSelected;
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$day',
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  isSelected || isToday ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
