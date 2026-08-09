class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class QuizSet {
  final String id;
  final String title;
  final bool isPremium;
  final List<QuizQuestion> questions;

  const QuizSet({
    required this.id,
    required this.title,
    required this.questions,
    this.isPremium = false,
  });
}
