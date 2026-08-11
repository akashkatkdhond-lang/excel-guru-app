/// One "Spot the Mistake" mini-game round — shows a broken formula/setup,
/// user picks what's wrong with it from options.
class MistakeChallenge {
  final String scenario;
  final String shownFormula;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const MistakeChallenge({
    required this.scenario,
    required this.shownFormula,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
