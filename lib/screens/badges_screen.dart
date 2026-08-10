import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/badges_data.dart';
import '../data/lessons_data.dart';
import '../services/language_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final language = context.watch<LanguageService>().language;
    final unlocked = progress.unlockedBadgeIds(totalLessonCount: lessonsFor(language).length);

    return Scaffold(
      appBar: AppBar(title: const Text('Badges')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemCount: allBadges.length,
        itemBuilder: (context, index) {
          final badge = allBadges[index];
          final isUnlocked = unlocked.contains(badge.id);
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUnlocked ? AppTheme.excelGreen.withOpacity(0.08) : Colors.grey.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUnlocked ? AppTheme.excelGreen.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: isUnlocked ? 1 : 0.3,
                  child: Text(badge.icon, style: const TextStyle(fontSize: 40)),
                ),
                const SizedBox(height: 10),
                Text(
                  badge.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.black87 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  badge.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                if (!isUnlocked) ...[
                  const SizedBox(height: 6),
                  const Icon(Icons.lock, size: 16, color: Colors.grey),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
