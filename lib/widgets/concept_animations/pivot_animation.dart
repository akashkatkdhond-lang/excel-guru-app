import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'concept_animation_scaffold.dart';

const _rawRows = [
  ['Delhi', 20],
  ['Mumbai', 15],
  ['Delhi', 30],
  ['Mumbai', 25],
  ['Pune', 10],
  ['Delhi', 15],
];
const _grouped = [
  ['Delhi', 65],
  ['Mumbai', 40],
  ['Pune', 10],
];

/// Visualizes a Pivot Table: messy raw rows fade out on the left while
/// grouped/summed rows fade in on the right, showing the "before → after".
class PivotAnimation extends StatelessWidget {
  const PivotAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ConceptAnimationScaffold(
      title: 'Pivot Table kaise data summarize karta hai',
      caption: 'Bikhri hui raw rows (baayi taraf) ko city ke hisaab se group karke, Pivot Table ek click me total nikal deta hai (daayi taraf).',
      bodyBuilder: (context, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final t = controller.value;
            final rawOpacity = (1 - t * 1.3).clamp(0.0, 1.0);
            final groupedT = ((t - 0.35) / 0.65).clamp(0.0, 1.0);

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Raw messy data.
                Expanded(
                  child: Opacity(
                    opacity: rawOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Raw Data', style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        for (final row in _rawRows)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                                const SizedBox(width: 6),
                                Text('${row[0]}: ${row[1]}', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: AppTheme.excelGreen.withOpacity(0.5 + 0.5 * groupedT)),
                const SizedBox(width: 8),
                // Grouped/summarized result.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pivot Table', style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      for (var i = 0; i < _grouped.length; i++) _buildGroupedRow(i, groupedT),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildGroupedRow(int i, double groupedT) {
    final start = i * 0.15;
    final local = ((groupedT - start) / 0.5).clamp(0.0, 1.0);
    if (local <= 0) return const SizedBox(height: 34);
    final row = _grouped[i];
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Opacity(
        opacity: local,
        child: Transform.translate(
          offset: Offset((1 - local) * 16, 0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppTheme.excelGreen.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
            child: Text('${row[0]}: ${row[1]}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.excelGreenDark)),
          ),
        ),
      ),
    );
  }
}
