import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'concept_animation_scaffold.dart';

const _rows = [
  ['Amit', '450'],
  ['Priya', '620'],
  ['Rahul', '380'],
  ['Sneha', '710'],
];
const _targetRow = 2; // "Rahul" — the row VLOOKUP is searching for.

/// Visualizes VLOOKUP: a highlight bar scans down the rows looking for a
/// match, then an arrow jumps across to pull the value from column 2.
class VlookupAnimation extends StatelessWidget {
  const VlookupAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ConceptAnimationScaffold(
      title: 'VLOOKUP kaise dhundhta hai',
      caption: '=VLOOKUP("Rahul", table, 2, FALSE) — Excel pehle column me "Rahul" dhundhta hai, match milte hi usi row se doosra column ka data utha leta hai.',
      bodyBuilder: (context, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final t = controller.value;
            // Scan phase: 0.0 - 0.55, jump phase: 0.55 - 0.85, settle: 0.85-1.0
            final scanT = (t / 0.55).clamp(0.0, 1.0);
            final scanRow = (scanT * _targetRow).clamp(0.0, _targetRow.toDouble());
            final jumpT = ((t - 0.55) / 0.3).clamp(0.0, 1.0);
            const rowHeight = 40.0;
            const colWidth = 110.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  SizedBox(width: colWidth, child: Text('Naam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                  SizedBox(width: colWidth, child: Text('Sales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                ]),
                const SizedBox(height: 4),
                SizedBox(
                  height: rowHeight * _rows.length,
                  child: Stack(
                    children: [
                      for (var i = 0; i < _rows.length; i++)
                        Positioned(
                          top: i * rowHeight,
                          left: 0,
                          right: 0,
                          child: Row(
                            children: [
                              SizedBox(
                                width: colWidth,
                                child: Text(_rows[i][0], style: TextStyle(fontWeight: i == _targetRow && t > 0.5 ? FontWeight.bold : FontWeight.normal)),
                              ),
                              SizedBox(
                                width: colWidth,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: (i == _targetRow && jumpT > 0.3)
                                      ? BoxDecoration(color: AppTheme.accent.withOpacity(0.4), borderRadius: BorderRadius.circular(6))
                                      : null,
                                  child: Text(_rows[i][1]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Scanning highlight bar over column 1.
                      if (t < 0.58)
                        Positioned(
                          top: scanRow * rowHeight,
                          left: 0,
                          width: colWidth,
                          height: rowHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.excelGreen.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppTheme.excelGreen, width: 1.5),
                            ),
                          ),
                        ),
                      // Arrow jumping from col1 to col2 at the matched row.
                      if (jumpT > 0 && jumpT < 1)
                        Positioned(
                          top: _targetRow * rowHeight + rowHeight / 2 - 8,
                          left: colWidth * 0.6 + (colWidth * 0.5 * jumpT),
                          child: Opacity(
                            opacity: (jumpT * 3).clamp(0.0, 1.0) * (1 - (jumpT > 0.85 ? (jumpT - 0.85) * 6 : 0)).clamp(0.0, 1.0),
                            child: const Icon(Icons.arrow_forward_rounded, color: AppTheme.excelGreenDark, size: 18),
                          ),
                        ),
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
}
