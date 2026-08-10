import 'package:flutter/material.dart';
import '../data/formula_tips_data.dart';
import '../theme/app_theme.dart';

/// Shows the current daily streak plus today's "Formula of the Day" tip.
/// Sits on the Home screen, right under the welcome banner.
class StreakCard extends StatelessWidget {
  const StreakCard({super.key, required this.currentStreak});
  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final tip = todaysFormulaTip();
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🔥', style: TextStyle(fontSize: 26)),
                const SizedBox(height: 4),
                Text('$currentStreak din',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Streak', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.excelGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.excelGreen.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡 Formula of the Day',
                    style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(tip.formula,
                    style: const TextStyle(
                        fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(tip.tip, style: const TextStyle(fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
