import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/badges_data.dart';

/// Tracks completed lessons, quiz scores, streaks, badges and the premium
/// flag using SharedPreferences (simple, no backend needed for v1).
class ProgressService extends ChangeNotifier {
  static const _premiumKey = 'is_premium';
  static const _completedLessonsKey = 'completed_lessons';
  static const _quizScoresKeyPrefix = 'quiz_score_';
  static const _lastOpenDateKey = 'last_open_date';
  static const _currentStreakKey = 'current_streak';
  static const _longestStreakKey = 'longest_streak';
  static const _perfectQuizKey = 'has_perfect_quiz';
  static const _completedLevelsKey = 'completed_levels';

  SharedPreferences? _prefs;
  bool _isPremium = false;
  final Set<String> _completedLessons = {};
  final Set<int> _completedLevels = {};
  int _currentStreak = 0;
  int _longestStreak = 0;
  bool _hasPerfectQuiz = false;
  int _totalQuizzesTaken = 0;

  bool get isPremium => _isPremium;
  Set<String> get completedLessons => _completedLessons;
  Set<int> get completedLevels => _completedLevels;
  int get currentStreak => _currentStreak;
  int get longestStreak => _longestStreak;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isPremium = _prefs?.getBool(_premiumKey) ?? false;
    _completedLessons
      ..clear()
      ..addAll(_prefs?.getStringList(_completedLessonsKey) ?? []);
    _completedLevels
      ..clear()
      ..addAll((_prefs?.getStringList(_completedLevelsKey) ?? []).map(int.parse));
    _currentStreak = _prefs?.getInt(_currentStreakKey) ?? 0;
    _longestStreak = _prefs?.getInt(_longestStreakKey) ?? 0;
    _hasPerfectQuiz = _prefs?.getBool(_perfectQuizKey) ?? false;
    _totalQuizzesTaken = _countSavedQuizScores();
    await _updateStreakOnOpen();
    notifyListeners();
  }

  int _countSavedQuizScores() {
    final keys = _prefs?.getKeys() ?? {};
    return keys.where((k) => k.startsWith(_quizScoresKeyPrefix)).length;
  }

  /// Call once per app launch. Bumps the streak if today is the day after
  /// the last recorded open, resets it if a day was missed, and does
  /// nothing if the app was already opened today.
  Future<void> _updateStreakOnOpen() async {
    final today = _dateOnly(DateTime.now());
    final lastOpenStr = _prefs?.getString(_lastOpenDateKey);

    if (lastOpenStr == null) {
      _currentStreak = 1;
    } else {
      final lastOpen = DateTime.parse(lastOpenStr);
      final daysSince = today.difference(lastOpen).inDays;
      if (daysSince == 0) {
        // Already counted today — no change.
        return;
      } else if (daysSince == 1) {
        _currentStreak += 1;
      } else {
        _currentStreak = 1;
      }
    }

    if (_currentStreak > _longestStreak) _longestStreak = _currentStreak;

    await _prefs?.setString(_lastOpenDateKey, today.toIso8601String());
    await _prefs?.setInt(_currentStreakKey, _currentStreak);
    await _prefs?.setInt(_longestStreakKey, _longestStreak);
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

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

  /// A level `n` is playable if it's level 1, or level `n-1` is already
  /// completed. Premium levels additionally require [isPremium].
  bool isLevelUnlocked(int levelNumber, {required bool isPremiumLevel}) {
    if (isPremiumLevel && !_isPremium) return false;
    if (levelNumber <= 1) return true;
    return _completedLevels.contains(levelNumber - 1);
  }

  Future<void> markLevelComplete(int levelNumber) async {
    _completedLevels.add(levelNumber);
    await _prefs?.setStringList(
      _completedLevelsKey,
      _completedLevels.map((n) => n.toString()).toList(),
    );
    notifyListeners();
  }

  Future<void> saveQuizScore(String quizId, int score, int total) async {
    final isFirstAttempt = _prefs?.getString('$_quizScoresKeyPrefix$quizId') == null;
    await _prefs?.setString('$_quizScoresKeyPrefix$quizId', '$score/$total');
    if (isFirstAttempt) _totalQuizzesTaken++;
    if (total > 0 && score == total) {
      _hasPerfectQuiz = true;
      await _prefs?.setBool(_perfectQuizKey, true);
    }
    notifyListeners();
  }

  String? getQuizScore(String quizId) {
    return _prefs?.getString('$_quizScoresKeyPrefix$quizId');
  }

  /// Evaluates unlock conditions for every badge in [allBadges].
  /// [totalLessonCount] is passed in from the lesson catalog so this
  /// service doesn't need to import lesson data directly.
  Set<String> unlockedBadgeIds({required int totalLessonCount}) {
    final unlocked = <String>{};
    final done = _completedLessons.length;

    if (done > 0) unlocked.add('first_lesson');
    if (_totalQuizzesTaken > 0) unlocked.add('first_quiz');

    if (totalLessonCount > 0) {
      if (done >= 1) unlocked.add('level_beginner');
      if (done >= (totalLessonCount * 0.4).ceil()) unlocked.add('level_intermediate');
      if (done >= (totalLessonCount * 0.7).ceil()) unlocked.add('level_advanced');
      if (done >= totalLessonCount) unlocked.add('level_expert');
    }

    if (_currentStreak >= 3) unlocked.add('streak_3');
    if (_currentStreak >= 7) unlocked.add('streak_7');
    if (_hasPerfectQuiz) unlocked.add('perfect_quiz');
    return unlocked;
  }

  /// The user's current level label, shown on Home. Mirrors the level_*
  /// badge thresholds in [unlockedBadgeIds].
  String currentLevelLabel({required int totalLessonCount}) {
    final unlocked = unlockedBadgeIds(totalLessonCount: totalLessonCount);
    if (unlocked.contains('level_expert')) return 'Excel Expert';
    if (unlocked.contains('level_advanced')) return 'Advanced';
    if (unlocked.contains('level_intermediate')) return 'Intermediate';
    if (unlocked.contains('level_beginner')) return 'Beginner';
    return 'Naya Seekhne Wala';
  }

  /// A stable, unique-looking certificate ID — generated once per install
  /// and reused for every certificate share afterwards.
  String get certificateId {
    var id = _prefs?.getString(_certificateIdKey);
    if (id == null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      id = 'EG-${now.toRadixString(36).toUpperCase()}';
      _prefs?.setString(_certificateIdKey, id);
    }
    return id;
  }

  static const _certificateIdKey = 'certificate_id';
}
