import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'concept_animation_scaffold.dart';

/// Visualizes IF as a fork in the road: a dot travels from the condition
/// box down whichever path is TRUE, while the other path stays dim.
class IfAnimation extends StatelessWidget {
  const IfAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ConceptAnimationScaffold(
      title: '=IF(A1>40,"Pass","Fail") — kaise decide hota hai',
      caption: 'Marks (A1) 40 se zyada hai, isliye condition TRUE hui — Excel "Pass" wala path follow karta hai, "Fail" wala path chhod deta hai.',
      bodyBuilder: (context, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final t = controller.value;
            final travelT = (t / 0.75).clamp(0.0, 1.0);
            final labelOpacity = ((t - 0.75) / 0.25).clamp(0.0, 1.0);

            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final centerX = width / 2;
                final trueX = width * 0.78;
                // Dot path: starts at top-center, curves to the TRUE branch.
                final dx = centerX + (trueX - centerX) * Curves.easeInOut.transform(travelT);
                final dy = 46 + travelT * 100;

                return Stack(
                  children: [
                    // Condition box.
                    Positioned(
                      left: centerX - 55,
                      top: 0,
                      child: Container(
                        width: 110,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
                        child: const Text('A1 > 40 ?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                    // TRUE branch label.
                    Positioned(
                      left: width * 0.78 - 34,
                      top: 150,
                      child: Opacity(
                        opacity: 0.5 + 0.5 * labelOpacity,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: AppTheme.excelGreen, borderRadius: BorderRadius.circular(8)),
                          child: const Text('TRUE\n"Pass"', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    // FALSE branch label (dim).
                    Positioned(
                      left: width * 0.22 - 34,
                      top: 150,
                      child: Opacity(
                        opacity: 0.25,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(8)),
                          child: const Text('FALSE\n"Fail"', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    // The traveling dot.
                    Positioned(
                      left: dx - 7,
                      top: dy,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(color: AppTheme.accent, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
