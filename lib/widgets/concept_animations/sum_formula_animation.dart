import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'concept_animation_scaffold.dart';

const _values = [20, 30, 10];

/// Visualizes =SUM(A1:A3): three number chips fly down into a total box
/// while a running counter adds them up.
class SumFormulaAnimation extends StatelessWidget {
  const SumFormulaAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ConceptAnimationScaffold(
      title: '=SUM(A1:A3) kaise kaam karta hai',
      caption: 'Har cell ki value ek-ek karke total box me "gir" ke jud jaati hai — SUM bas yehi karta hai, poori range ko add kar deta hai.',
      bodyBuilder: (context, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final t = controller.value;
            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final chipSpacing = width / (_values.length + 1);
                return Stack(
                  children: [
                    // Total box at the bottom.
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 110,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.excelGreen,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: AppTheme.excelGreen.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Text(_runningTotal(t).toString(), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    for (var i = 0; i < _values.length; i++) _buildChip(i, t, chipSpacing, width),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  int _runningTotal(double t) {
    var sum = 0;
    for (var i = 0; i < _values.length; i++) {
      final start = i * 0.2;
      if (t >= start + 0.35) sum += _values[i];
    }
    return sum;
  }

  Widget _buildChip(int i, double t, double spacing, double width) {
    final start = i * 0.2;
    const duration = 0.4;
    final local = ((t - start) / duration).clamp(0.0, 1.0);
    final curved = Curves.easeIn.transform(local);

    final startX = spacing * (i + 1) - 24;
    final endX = width / 2 - 24;
    final x = startX + (endX - startX) * curved;
    final y = curved * 118; // travel down towards the total box
    final opacity = local >= 1.0 ? (1 - ((t - (start + duration)) * 3)).clamp(0.0, 1.0) : 1.0;

    if (opacity <= 0) return const SizedBox.shrink();

    return Positioned(
      left: x,
      top: y,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 48,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('${_values[i]}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
