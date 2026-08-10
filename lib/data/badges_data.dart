import '../models/app_badge.dart';

/// All badges available in the app. Unlock conditions are evaluated in
/// [ProgressService.unlockedBadgeIds] — add the matching check there
/// whenever a new badge is added here.
final List<AppBadge> allBadges = [
  const AppBadge(
    id: 'first_lesson',
    title: 'Pehla Kadam',
    description: 'Apna pehla lesson complete kiya',
    icon: '🌱',
  ),
  const AppBadge(
    id: 'first_quiz',
    title: 'Quiz Shuru',
    description: 'Apna pehla quiz complete kiya',
    icon: '📝',
  ),
  const AppBadge(
    id: 'all_lessons',
    title: 'Excel Guru',
    description: 'Sabhi lessons complete kiye',
    icon: '🏆',
  ),
  const AppBadge(
    id: 'streak_3',
    title: '3-Din Streak',
    description: 'Lagataar 3 din practice kiya',
    icon: '🔥',
  ),
  const AppBadge(
    id: 'streak_7',
    title: '7-Din Streak',
    description: 'Lagataar 7 din practice kiya',
    icon: '⚡',
  ),
  const AppBadge(
    id: 'perfect_quiz',
    title: 'Perfect Score',
    description: 'Kisi quiz me 100% score kiya',
    icon: '💯',
  ),
];
