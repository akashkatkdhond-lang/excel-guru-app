/// One fillable parameter in a [FormulaTemplate] — shown as a text field
/// with a hint in the Formula Builder Wizard.
class FormulaParam {
  final String label;
  final String hint;

  const FormulaParam({required this.label, required this.hint});
}

/// A function whose formula can be built step-by-step by filling in
/// parameters instead of typing the whole thing. [template] uses {0},
/// {1}, ... placeholders matching the index in [params].
class FormulaTemplate {
  final String functionName;
  final String description;
  final String template;
  final List<FormulaParam> params;

  const FormulaTemplate({
    required this.functionName,
    required this.description,
    required this.template,
    required this.params,
  });

  String build(List<String> values) {
    var result = template;
    for (var i = 0; i < values.length; i++) {
      final value = values[i].trim().isEmpty ? '?' : values[i].trim();
      result = result.replaceAll('{$i}', value);
    }
    return result;
  }
}
