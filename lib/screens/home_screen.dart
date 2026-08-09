import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/lessons_data.dart';
import '../data/quiz_data.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';
import 'lesson_list_screen.dart';
import 'premium_screen.dart';
import 'quiz_list_screen.dart';
import 'simulator_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final completedCount = progress.completedLessons.length;
    final total = lessons.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Excel Guru')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _WelcomeCard(completed: completedCount, total: total),
                  const SizedBox(height: 20),
                  Text('Seekhna shuru karein', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
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
                    subtitle: '${quizSets.length} quiz sets — apna score check karein',
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
  const _WelcomeCard({required this.completed, required this.total});
  final int completed;
  final int total;

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
          const Text('Namaste! 👋',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
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
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.15), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
