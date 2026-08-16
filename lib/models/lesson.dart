/// A single learning section inside a lesson (heading + explanation + example).
class LessonSection {
  final String heading;
  final String content;
  final String? formulaExample;

  /// A short, relatable real-life analogy or "did you know" nugget shown
  /// in a highlighted callout box — makes the section more fun/memorable
  /// instead of just dry theory.
  final String? funFact;

  /// Optional key into the concept-animation registry (see
  /// widgets/concept_animations/animation_registry.dart). When set, the
  /// section shows a "▶ Animation Dekho" button that plays a short
  /// animated visual explanation of the concept.
  final String? animationKey;

  const LessonSection({
    required this.heading,
    required this.content,
    this.formulaExample,
    this.funFact,
    this.animationKey,
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
