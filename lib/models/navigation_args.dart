import 'package:moodle/models/assessment.dart';
import 'package:moodle/models/course.dart';

class CourseDetailsArguments {
  const CourseDetailsArguments({
    required this.course,
    this.initialSection = 0,
  });

  final Course course;
  final int initialSection;
}

class AssignmentArguments {
  const AssignmentArguments({
    required this.assessment,
  });

  final Assessment assessment;
}
