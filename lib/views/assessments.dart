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
      body: Container(
        color: moodleBg,
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'This is the assessments page.',
                style: TextStyle(fontSize: 16, color: moodleTextDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
