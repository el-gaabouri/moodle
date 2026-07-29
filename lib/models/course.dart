class Course {
  const Course({
    required this.name,
    required this.module,
    required this.department,
  });

  final String name;
  final String module;
  final String department;
}

const List<Course> courses = [
  Course(
    name: 'Programming Applications and Programming Languages',
    module: 'M30235',
    department: 'School of Computing',
  ),
  Course(
    name: 'Discrete Mathematics And Functional Programming',
    module: 'M21274',
    department: 'School of Mathematics and Physics',
  ),
  Course(
    name: 'Software Engineering Theory and Practice',
    module: 'M30819',
    department: 'School of Computing',
  ),
  Course(
    name: 'Database Systems',
    module: 'M30234',
    department: 'School of Computing',
  ),
  Course(
    name: 'Web Foundations',
    module: 'M30229',
    department: 'School of Computing',
  ),
  Course(
    name: 'Computer Networks',
    module: 'M30231',
    department: 'School of Computing',
  ),
];
