/// One entry in the searchable Function Reference — a quick lookup
/// dictionary of real Excel functions (separate from Lessons/Levels).
class ExcelFunction {
  final String name;
  final String category;
  final String syntax;
  final String description;

  const ExcelFunction({
    required this.name,
    required this.category,
    required this.syntax,
    required this.description,
  });
}
