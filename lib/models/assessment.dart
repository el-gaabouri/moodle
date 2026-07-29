class Assessment {
  Assessment({
    required this.title,
    required this.moduleName,
    required this.dueDate,
    required this.status,
    required this.section,
    required this.assignmentDetails,
  });

  final String title;
  final String moduleName;
  final DateTime dueDate;
  final AssessmentStatus status;
  final AssessmentSection section;
  final AssignmentSubmissionDetails assignmentDetails;
}

class AssignmentSubmissionDetails {
  const AssignmentSubmissionDetails({
    required this.title,
    required this.statusHeading,
    required this.gradingStatus,
    required this.lastModified,
    required this.submissionComments,
  });

  final String title;
  final String statusHeading;
  final String gradingStatus;
  final String lastModified;
  final String submissionComments;
}

enum AssessmentStatus {
  notYetSubmitted,
  notAvailable,
  overdue,
  submitted,
}

extension AssessmentStatusLabel on AssessmentStatus {
  String get label {
    switch (this) {
      case AssessmentStatus.notYetSubmitted:
        return 'Not yet submitted';
      case AssessmentStatus.notAvailable:
        return 'Not available';
      case AssessmentStatus.overdue:
        return 'Overdue';
      case AssessmentStatus.submitted:
        return 'Submitted';
    }
  }
}

enum AssessmentSection {
  upcoming,
  past,
}

const AssignmentSubmissionDetails defaultAssignmentSubmissionDetails =
    AssignmentSubmissionDetails(
  title: 'Submit your assignment',
  statusHeading: 'Submission status',
  gradingStatus: 'Not marked',
  lastModified: '-',
  submissionComments: '',
);

final List<Assessment> assessments = [
  Assessment(
    title:
        'Item 1 (Flutter) - Referral and Deferral Coursework. Deadline: 29/07/2026 13:00pm (with the 48 hour extension: 31/07/2026 13:00pm)',
    dueDate: DateTime(2026, 7, 29, 13),
    moduleName:
        'M30235 - Programming Applications and Programming Languages (2025/26)',
    status: AssessmentStatus.notYetSubmitted,
    section: AssessmentSection.upcoming,
    assignmentDetails: defaultAssignmentSubmissionDetails,
  ),
  Assessment(
    title:
        'Ref/Def - Item 2 M30235 - Computer Based Exam (30 July 2026, 10:00 AM)',
    dueDate: DateTime(2026, 7, 30, 10),
    moduleName:
        'M30235 - Programming Applications and Programming Languages (2025/26)',
    status: AssessmentStatus.notAvailable,
    section: AssessmentSection.upcoming,
    assignmentDetails: defaultAssignmentSubmissionDetails,
  ),
  Assessment(
    title: 'Referral/Deferral Functional Programming Assessment',
    dueDate: DateTime(2026, 7, 10),
    moduleName:
        'M21274-2025/26-SMJAN: Discrete Mathematics And Functional Programming (MATHFUN) (2025/26)',
    status: AssessmentStatus.overdue,
    section: AssessmentSection.past,
    assignmentDetails: defaultAssignmentSubmissionDetails,
  ),
  Assessment(
    title: 'Item 2 - Coursework - EC/late (Due Date: 28.5.2026 13:00pm)',
    dueDate: DateTime(2026, 6, 26),
    moduleName:
        'M30819-2025/26-SMYEAR: Software Engineering Theory and Practice (2025/26)',
    status: AssessmentStatus.submitted,
    section: AssessmentSection.past,
    assignmentDetails: defaultAssignmentSubmissionDetails,
  ),
];

List<Assessment> assessmentsForSection(AssessmentSection section) {
  return assessments.where((Assessment assessment) {
    return assessment.section == section;
  }).toList();
}

List<Assessment> assessmentsForDate(DateTime date) {
  return assessments.where((Assessment assessment) {
    return assessment.dueDate.year == date.year &&
        assessment.dueDate.month == date.month &&
        assessment.dueDate.day == date.day;
  }).toList();
}

String formatAssessmentDate(DateTime date) {
  return '${date.day} ${assessmentMonthName(date.month)} ${date.year}';
}

String assessmentMonthName(int month) {
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
