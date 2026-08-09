import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../theme/app_theme.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
    required this.isCompleted,
    required this.isLocked,
    required this.onTap,
  });

  final Lesson lesson;
  final bool isCompleted;
  final bool isLocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: AppTheme.excelGreen.withOpacity(0.1),
          child: Text(lesson.icon, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(lesson.subtitle),
        trailing: isLocked
            ? const Icon(Icons.lock, color: Colors.grey)
            : isCompleted
                ? const Icon(Icons.check_circle, color: AppTheme.excelGreen)
                : const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
