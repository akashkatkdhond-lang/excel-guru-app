import 'package:flutter/material.dart';
import 'if_animation.dart';
import 'pivot_animation.dart';
import 'sum_formula_animation.dart';
import 'vlookup_animation.dart';

/// Maps a [LessonSection.animationKey] to its animated widget. Add a new
/// entry here + a new widget file when a new concept animation is built.
final Map<String, WidgetBuilder> conceptAnimations = {
  'sum': (context) => const SumFormulaAnimation(),
  'vlookup': (context) => const VlookupAnimation(),
  'if': (context) => const IfAnimation(),
  'pivot': (context) => const PivotAnimation(),
};
