/// One step in the 50-level structured learning path (separate from the
/// topic-based Lessons). Levels are meant to be short, sequential, and
/// gamified — complete one to unlock the next.
class ExcelLevel {
  final int number; // 1-50, also used as the unlock/progress key
  final String title;
  final String category;
  final String explanation;
  final String? formulaExample;
  final bool isPremium;

  const ExcelLevel({
    required this.number,
    required this.title,
    required this.category,
    required this.explanation,
    this.formulaExample,
    this.isPremium = false,
  });
}
