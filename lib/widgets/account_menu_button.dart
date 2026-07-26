import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class AccountMenuButton extends StatelessWidget {
  const AccountMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Account menu',
      offset: const Offset(0, 44),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      onSelected: (String value) {
        if (value == 'profile') {
          Navigator.pushNamed(context, '/profile');
        }

        if (value == 'logout') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (Route<dynamic> route) => false,
          );
        }
      },
      itemBuilder: (BuildContext context) {
        return const [
          PopupMenuItem<String>(
            value: 'profile',
            child: Text('Profile'),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: Text('Logout'),
          ),
        ];
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
    );
  }
}
