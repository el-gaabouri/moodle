import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';

class AppBarNavLinks extends StatelessWidget {
  const AppBarNavLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AppBarNavLink(
          label: 'Dashboard',
          route: '/',
          selected: currentRoute == '/',
        ),
        _AppBarNavLink(
          label: 'My courses',
          route: '/courses',
          selected: currentRoute == '/courses',
        ),
        _AppBarNavLink(
          label: 'My assessments',
          route: '/assessments',
          selected: currentRoute == '/assessments',
        ),
      ],
    );
  }
}

class _AppBarNavLink extends StatelessWidget {
  const _AppBarNavLink({
    required this.label,
    required this.route,
    required this.selected,
  });

  final String label;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: selected
          ? null
          : () {
              Navigator.pushReplacementNamed(context, route);
            },
      child: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? moodlePurple : moodleBlue,
        ),
      ),
    );
  }
}
