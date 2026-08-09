import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/lessons_data.dart';
import '../services/progress_service.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/lesson_card.dart';
import 'lesson_detail_screen.dart';
import 'premium_screen.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  final isLocked = lesson.isPremium && !progress.isPremium;
                  final isCompleted = progress.completedLessons.contains(lesson.id);
                  return LessonCard(
                    lesson: lesson,
                    isCompleted: isCompleted,
                    isLocked: isLocked,
                    onTap: () {
                      if (isLocked) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PremiumScreen()),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson)),
                      );
                    },
                  );
                },
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
}
