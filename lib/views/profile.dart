import 'package:flutter/material.dart';
import 'package:moodle/widgets/account_menu_button.dart';
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
            Row(
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
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Anass El Gaabouri',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: moodlePurple,
                    ),
                  ),
                ),
              ],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: moodlePurple,
                      ),
                    ),
                    SizedBox(height: 12),
                    Divider(height: 1, thickness: 1, color: moodleBorder),
                    SizedBox(height: 20),
                    Text(
                      'Email address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Anass.ElGaabouri@myport.ac.uk',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Student ID',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2268566',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Course',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'BSC (HONS) COMPUTER SCIENCE',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Route',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Computer Science',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Faculty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Faculty of Technology',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Timezone',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Europe/London',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Course details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: moodlePurple,
                      ),
                    ),
                    SizedBox(height: 12),
                    Divider(height: 1, thickness: 1, color: moodleBorder),
                    SizedBox(height: 20),
                    Text(
                      'Course profiles',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: moodleTextDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M34704-2026/27-SMYEAR, M24739-2025/26-SMYEAR M34704 Engineering Project / M34703 Study Project (2026/27)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M30233-2025/26-SMSEP Operating Systems and Internetworking (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M30819-2025/26-SMYEAR Software Engineering Theory and Practice (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M30235-2025/26-SMYEAR Programming Applications and Programming Languages (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M22732-2025/26-SMYEAR COMP TUTORIAL LEVEL 5 (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M21270-2025/26-SMSEP Data Structures and Algorithms (DSALG) (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M33122-2025/26-SMJAN Security And Cryptography (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'M21274-2025/26-SMJAN Discrete Mathematics And Functional Programming (MATHFUN) (2025/26)',
                      style: TextStyle(fontSize: 16, color: moodleTextDark),
                    ),
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
