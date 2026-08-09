import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../services/ad_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class LessonDetailScreen extends StatefulWidget {
  const LessonDetailScreen({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressService>().markLessonComplete(widget.lesson.id);
    });
  }

  @override
  void dispose() {
    final isPremium = context.read<ProgressService>().isPremium;
    if (!isPremium) AdService.instance.maybeShowInterstitial();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final section in lesson.sections) ...[
            Text(section.heading,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(section.content, style: const TextStyle(fontSize: 15, height: 1.4)),
            if (section.formulaExample != null) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.excelGreen.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.excelGreen.withOpacity(0.3)),
                ),
                child: Text(
                  section.formulaExample!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: AppTheme.excelGreenDark,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 22),
          ],
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppTheme.excelGreen, size: 20),
              const SizedBox(width: 8),
              const Expanded(child: Text('Lesson complete mark ho gaya!')),
            ],
          ),
        ],
      ),
    );
  }
}
