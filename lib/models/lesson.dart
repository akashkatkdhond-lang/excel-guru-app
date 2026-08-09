/// A single learning section inside a lesson (heading + explanation + example).
class LessonSection {
  final String heading;
  final String content;
  final String? formulaExample;

  const LessonSection({
    required this.heading,
    required this.content,
    this.formulaExample,
  });
}

/// One full lesson shown in the Lessons tab.
class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String icon; // emoji used as a lightweight icon, no asset needed
  final bool isPremium;
  final List<LessonSection> sections;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.sections,
    this.isPremium = false,
  });
}
