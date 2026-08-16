/// One rotating Daily Challenge question. A new one "unlocks" every
/// calendar day (same challenge for every user that day, Wordle-style),
/// picked deterministically from [dailyChallenges] using the day-of-year.
class DailyChallenge {
  final String prompt;
  final String? formulaOrScenario;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const DailyChallenge({
    required this.prompt,
    this.formulaOrScenario,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
