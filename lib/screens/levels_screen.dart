import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/levels_data.dart';
import '../models/excel_level.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';
import 'level_detail_screen.dart';
import 'premium_screen.dart';

/// The 50-level gamified path — complete a level to unlock the next.
/// Separate from the topic-based Lessons; this is the structured,
/// step-by-step curriculum (levels 1-25 free, 26-50 premium).
class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final completedCount = progress.completedLevels.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Levels')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: completedCount / excelLevels.length,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.excelGreen),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('$completedCount / ${excelLevels.length} levels complete',
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: excelLevels.length,
                itemBuilder: (context, index) {
                  final level = excelLevels[index];
                  final isCompleted = progress.completedLevels.contains(level.number);
                  final isUnlocked = progress.isLevelUnlocked(level.number, isPremiumLevel: level.isPremium);
                  return _LevelTile(
                    level: level,
                    isCompleted: isCompleted,
                    isUnlocked: isUnlocked,
                    onTap: () {
                      if (!isUnlocked) {
                        if (level.isPremium && !progress.isPremium) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pehle pichhla level complete karein 🔒')),
                          );
                        }
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LevelDetailScreen(level: level)),
                      );
                    },
                  );
                },
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
}

class _LevelTile extends StatelessWidget {
  const _LevelTile({
    required this.level,
    required this.isCompleted,
    required this.isUnlocked,
    required this.onTap,
  });

  final ExcelLevel level;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locked = !isUnlocked;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: locked ? Theme.of(context).cardColor.withOpacity(0.5) : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: isCompleted
              ? AppTheme.excelGreen
              : locked
                  ? Colors.grey.shade300
                  : AppTheme.accent.withOpacity(0.25),
          child: isCompleted
              ? const Icon(Icons.check, color: Colors.white, size: 20)
              : locked
                  ? const Icon(Icons.lock, color: Colors.grey, size: 18)
                  : Text('${level.number}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        title: Text(
          level.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: locked ? Colors.grey : null,
          ),
        ),
        subtitle: Text(level.category, style: TextStyle(color: locked ? Colors.grey : Colors.grey.shade600, fontSize: 12)),
        trailing: level.isPremium
            ? Icon(Icons.workspace_premium, size: 18, color: locked ? Colors.grey : AppTheme.accent)
            : null,
        onTap: onTap,
      ),
    );
  }
}
