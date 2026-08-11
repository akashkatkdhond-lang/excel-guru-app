import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/functions_data.dart';
import '../data/lessons_data.dart';
import '../data/levels_data.dart';
import '../data/quiz_data.dart';
import '../services/language_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/streak_card.dart';
import 'badges_screen.dart';
import 'certificate_screen.dart';
import 'formula_builder_screen.dart';
import 'function_reference_screen.dart';
import 'lesson_list_screen.dart';
import 'levels_screen.dart';
import 'premium_screen.dart';
import 'quiz_list_screen.dart';
import 'settings_screen.dart';
import 'simulator_screen.dart';
import 'spot_the_mistake_screen.dart';
import 'stats_share_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final language = context.watch<LanguageService>().language;
    final completedCount = progress.completedLessons.length;
    final total = lessonsFor(language).length;
    final allLessonsDone = total > 0 && completedCount >= total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel Guru'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _WelcomeCard(
                    completed: completedCount,
                    total: total,
                    level: progress.currentLevelLabel(totalLessonCount: total),
                  ),
                  const SizedBox(height: 14),
                  StreakCard(currentStreak: progress.currentStreak),
                  const SizedBox(height: 20),
                  Text('Seekhna shuru karein', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  _MenuTile(
                    icon: Icons.stairs_rounded,
                    title: '50 Levels — Step-by-Step Path',
                    subtitle: '${progress.completedLevels.length} / ${excelLevels.length} levels complete',
                    color: Colors.teal,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LevelsScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.menu_book_rounded,
                    title: 'Lessons',
                    subtitle: '$total topics — basics se advanced tak',
                    color: AppTheme.excelGreen,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LessonListScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.quiz_rounded,
                    title: 'Quiz',
                    subtitle: '${quizSetsFor(language).length} quiz sets — apna score check karein',
                    color: Colors.deepOrange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizListScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.grid_on_rounded,
                    title: 'Practice Simulator',
                    subtitle: 'Live spreadsheet me formulas try karein',
                    color: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SimulatorScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.build_circle_rounded,
                    title: 'Formula Builder',
                    subtitle: 'Function choose karein, blanks bharein, formula ban jayega',
                    color: Colors.indigo,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FormulaBuilderScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.menu_book_outlined,
                    title: 'Function Reference',
                    subtitle: '${excelFunctions.length}+ functions ki searchable list',
                    color: Colors.brown,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FunctionReferenceScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.search_rounded,
                    title: 'Spot the Mistake',
                    subtitle: 'Galat formula dhundo — quick mini-game',
                    color: Colors.redAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SpotTheMistakeScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.emoji_events_rounded,
                    title: 'Badges',
                    subtitle: 'Apni achievements dekhein',
                    color: Colors.amber.shade800,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BadgesScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.ios_share_rounded,
                    title: 'Meri Progress Share Karein',
                    subtitle: 'Apna streak aur badges dosto ko dikhayein',
                    color: Colors.pink,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StatsShareScreen()),
                    ),
                  ),
                  _MenuTile(
                    icon: Icons.card_membership_rounded,
                    title: 'Completion Certificate',
                    subtitle: allLessonsDone
                        ? 'Apna certificate banayein aur share karein'
                        : 'Sabhi lessons complete karke unlock karein',
                    color: Colors.purple,
                    isLocked: !progress.isPremium,
                    onTap: () {
                      if (!progress.isPremium) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PremiumScreen()),
                        );
                        return;
                      }
                      if (!allLessonsDone) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pehle sabhi lessons complete karein 🙂')),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CertificateScreen()),
                      );
                    },
                  ),
                  if (!progress.isPremium)
                    _MenuTile(
                      icon: Icons.workspace_premium_rounded,
                      title: 'Go Premium',
                      subtitle: 'Ads hatayein + saare advanced lessons unlock karein',
                      color: AppTheme.accent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PremiumScreen()),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.completed, required this.total, required this.level});
  final int completed;
  final int total;
  final String level;

  @override
  Widget build(BuildContext context) {
    final progressValue = total == 0 ? 0.0 : completed / total;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.excelGreen, AppTheme.excelGreenDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Namaste! 👋',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(level, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Excel seekhein, practice karein, expert banein.',
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
            ),
          ),
          const SizedBox(height: 6),
          Text('$completed / $total lessons complete',
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.isLocked = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.15), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(isLocked ? Icons.lock : Icons.chevron_right, color: isLocked ? Colors.grey : null),
        onTap: onTap,
      ),
    );
  }
}
