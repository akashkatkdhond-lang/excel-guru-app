/// A gamification badge the user can unlock. Named `AppBadge` (not `Badge`)
/// to avoid clashing with Flutter's built-in `Badge` widget.
class AppBadge {
  final String id;
  final String title;
  final String description;
  final String icon; // emoji

  const AppBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
