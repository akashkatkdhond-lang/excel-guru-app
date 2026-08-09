import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks completed lessons, quiz scores and the premium flag using
/// SharedPreferences (simple, no backend needed for v1).
class ProgressService extends ChangeNotifier {
  static const _premiumKey = 'is_premium';
  static const _completedLessonsKey = 'completed_lessons';
  static const _quizScoresKeyPrefix = 'quiz_score_';

  SharedPreferences? _prefs;
  bool _isPremium = false;
  final Set<String> _completedLessons = {};

  bool get isPremium => _isPremium;
  Set<String> get completedLessons => _completedLessons;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isPremium = _prefs?.getBool(_premiumKey) ?? false;
    _completedLessons
      ..clear()
      ..addAll(_prefs?.getStringList(_completedLessonsKey) ?? []);
    notifyListeners();
  }

  Future<void> setPremium(bool value) async {
    _isPremium = value;
    await _prefs?.setBool(_premiumKey, value);
    notifyListeners();
  }

  Future<void> markLessonComplete(String lessonId) async {
    _completedLessons.add(lessonId);
    await _prefs?.setStringList(_completedLessonsKey, _completedLessons.toList());
    notifyListeners();
  }

  Future<void> saveQuizScore(String quizId, int score, int total) async {
    await _prefs?.setString('$_quizScoresKeyPrefix$quizId', '$score/$total');
    notifyListeners();
  }

  String? getQuizScore(String quizId) {
    return _prefs?.getString('$_quizScoresKeyPrefix$quizId');
  }
}
