class Course {
  const Course({
    required this.name,
    required this.module,
    required this.department,
    required this.details,
  });

  final String name;
  final String module;
  final String department;
  final CourseDetails details;
}

class CourseDetails {
  const CourseDetails({
    required this.generalTitle,
    required this.resources,
    required this.referral,
    required this.moduleInfo,
    required this.readingLists,
  });

  final String generalTitle;
  final List<CourseResource> resources;
  final ReferralDetails referral;
  final List<CourseInfoItem> moduleInfo;
  final ReadingListsDetails readingLists;
}

class CourseResource {
  const CourseResource({
    required this.label,
    required this.type,
  });

  final String label;
  final CourseResourceType type;
}

enum CourseResourceType {
  announcements,
  folder,
}

class ReferralDetails {
  const ReferralDetails({
    required this.title,
    required this.description,
    this.briefIntro,
    this.briefLinkLabel,
    this.briefAssetPath,
    this.instructions,
  });

  final String title;
  final String description;
  final String? briefIntro;
  final String? briefLinkLabel;
  final String? briefAssetPath;
  final String? instructions;
}

class CourseInfoItem {
  const CourseInfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

class ReadingListsDetails {
  const ReadingListsDetails({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

const ReferralDetails genericReferralDetails = ReferralDetails(
  title: 'Referral and Deferral Assessments',
  description:
      'Assessment and support information for referral and deferral work will appear here.',
);

const String programmingApplicationsInstructions =
    'Paste the link to the GitHub repository for your coursework in the provided text field of the submission page and click on Save changes. You are not submitting any files for this coursework. You should have forked this repository and built upon it as instructed in the brief. This way, the submitted link should be of this format (where YOUR-USERNAME is replaced with your GitHub username):\n\n'
    'https://github.com/YOUR-USERNAME/moodle\n\n'
    'Make sure the repository is public. Check to see if it opens in an incognito/private window (you should not get a 404 error).\n\n'
    '\u26A0\uFE0F Do not make any commits after the deadline. I will label your submission as late if you do this.';

const List<Course> courses = [
  Course(
    name: 'Programming Applications and Programming Languages',
    module: 'M30235',
    department: 'School of Computing',
    details: CourseDetails(
      generalTitle: 'General',
      resources: [
        CourseResource(
          label: 'Announcements',
          type: CourseResourceType.announcements,
        ),
        CourseResource(
          label: 'M30235 course materials',
          type: CourseResourceType.folder,
        ),
      ],
      referral: ReferralDetails(
        title: 'Referral and Deferral Assessments',
        description: '',
        briefIntro: 'The coursework brief can be accessed via this link: ',
        briefLinkLabel: 'Flutter Referral and Deferral Coursework.pdf',
        briefAssetPath: 'images/flutter_ref_def_coursework.pdf',
        instructions: programmingApplicationsInstructions,
      ),
      moduleInfo: [
        CourseInfoItem(label: 'Module', value: 'M30235'),
        CourseInfoItem(label: 'Department', value: 'School of Computing'),
        CourseInfoItem(
          label: 'Course name',
          value: 'Programming Applications and Programming Languages',
        ),
      ],
      readingLists: ReadingListsDetails(
        title: 'Reading Lists',
        description:
            'Reading list links and course resources will appear here.',
      ),
    ),
  ),
  Course(
    name: 'Discrete Mathematics And Functional Programming',
    module: 'M21274',
    department: 'School of Mathematics and Physics',
    details: CourseDetails(
      generalTitle: 'General',
      resources: [
        CourseResource(
          label: 'Announcements',
          type: CourseResourceType.announcements,
        ),
        CourseResource(
          label: 'M21274 course materials',
          type: CourseResourceType.folder,
        ),
      ],
      referral: genericReferralDetails,
      moduleInfo: [
        CourseInfoItem(label: 'Module', value: 'M21274'),
        CourseInfoItem(
          label: 'Department',
          value: 'School of Mathematics and Physics',
        ),
        CourseInfoItem(
          label: 'Course name',
          value: 'Discrete Mathematics And Functional Programming',
        ),
      ],
      readingLists: ReadingListsDetails(
        title: 'Reading Lists',
        description:
            'Reading list links and course resources will appear here.',
      ),
    ),
  ),
  Course(
    name: 'Software Engineering Theory and Practice',
    module: 'M30819',
    department: 'School of Computing',
    details: CourseDetails(
      generalTitle: 'General',
      resources: [
        CourseResource(
          label: 'Announcements',
          type: CourseResourceType.announcements,
        ),
        CourseResource(
          label: 'M30819 course materials',
          type: CourseResourceType.folder,
        ),
      ],
      referral: genericReferralDetails,
      moduleInfo: [
        CourseInfoItem(label: 'Module', value: 'M30819'),
        CourseInfoItem(label: 'Department', value: 'School of Computing'),
        CourseInfoItem(
          label: 'Course name',
          value: 'Software Engineering Theory and Practice',
        ),
      ],
      readingLists: ReadingListsDetails(
        title: 'Reading Lists',
        description:
            'Reading list links and course resources will appear here.',
      ),
    ),
  ),
  Course(
    name: 'Database Systems',
    module: 'M30234',
    department: 'School of Computing',
    details: CourseDetails(
      generalTitle: 'General',
      resources: [
        CourseResource(
          label: 'Announcements',
          type: CourseResourceType.announcements,
        ),
        CourseResource(
          label: 'M30234 course materials',
          type: CourseResourceType.folder,
        ),
      ],
      referral: genericReferralDetails,
      moduleInfo: [
        CourseInfoItem(label: 'Module', value: 'M30234'),
        CourseInfoItem(label: 'Department', value: 'School of Computing'),
        CourseInfoItem(label: 'Course name', value: 'Database Systems'),
      ],
      readingLists: ReadingListsDetails(
        title: 'Reading Lists',
        description:
            'Reading list links and course resources will appear here.',
      ),
    ),
  ),
  Course(
    name: 'Web Foundations',
    module: 'M30229',
    department: 'School of Computing',
    details: CourseDetails(
      generalTitle: 'General',
      resources: [
        CourseResource(
          label: 'Announcements',
          type: CourseResourceType.announcements,
        ),
        CourseResource(
          label: 'M30229 course materials',
          type: CourseResourceType.folder,
        ),
      ],
      referral: genericReferralDetails,
      moduleInfo: [
        CourseInfoItem(label: 'Module', value: 'M30229'),
        CourseInfoItem(label: 'Department', value: 'School of Computing'),
        CourseInfoItem(label: 'Course name', value: 'Web Foundations'),
      ],
      readingLists: ReadingListsDetails(
        title: 'Reading Lists',
        description:
            'Reading list links and course resources will appear here.',
      ),
    ),
  ),
  Course(
    name: 'Computer Networks',
    module: 'M30231',
    department: 'School of Computing',
    details: CourseDetails(
      generalTitle: 'General',
      resources: [
        CourseResource(
          label: 'Announcements',
          type: CourseResourceType.announcements,
        ),
        CourseResource(
          label: 'M30231 course materials',
          type: CourseResourceType.folder,
        ),
      ],
      referral: genericReferralDetails,
      moduleInfo: [
        CourseInfoItem(label: 'Module', value: 'M30231'),
        CourseInfoItem(label: 'Department', value: 'School of Computing'),
        CourseInfoItem(label: 'Course name', value: 'Computer Networks'),
      ],
      readingLists: ReadingListsDetails(
        title: 'Reading Lists',
        description:
            'Reading list links and course resources will appear here.',
      ),
    ),
  ),
];
