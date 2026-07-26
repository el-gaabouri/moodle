import 'package:flutter/material.dart';
import 'package:moodle/widgets/nav_drawer.dart';
import 'package:moodle/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

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
                'My profile',
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
          TextButton(
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              minimumSize: const Size(36, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: moodleGrayBg,
              foregroundColor: moodlePurple,
              child: Text(
                'AE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: const NavDrawer(),
      backgroundColor: moodleBg,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: moodleGrayBg,
              foregroundColor: moodlePurple,
              child: Text(
                'AE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            Text(
              'Anass El Gaabouri',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: moodlePurple,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'This is the profile page.',
              style: TextStyle(fontSize: 16, color: moodleTextDark),
            ),
          ],
        ),
      ),
    );
  }
}
