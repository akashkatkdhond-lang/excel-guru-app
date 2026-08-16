import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../services/ad_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/concept_animations/animation_registry.dart';
import '../widgets/concept_animations/concept_animation_scaffold.dart';

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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.excelGreen, AppTheme.excelGreenDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(lesson.icon, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lesson.title,
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(lesson.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < lesson.sections.length; i++) ...[
            _SectionCard(index: i + 1, section: lesson.sections[i]),
            const SizedBox(height: 14),
          ],
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.excelGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: AppTheme.excelGreen, size: 22),
                SizedBox(width: 10),
                Expanded(child: Text('Lesson complete mark ho gaya! 🎉', style: TextStyle(fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.index, required this.section});
  final int index;
  final LessonSection section;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppTheme.excelGreen.withOpacity(0.15),
                  child: Text('$index', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.excelGreenDark)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(section.heading, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(section.content, style: const TextStyle(fontSize: 15, height: 1.45)),
            if (section.formulaExample != null) ...[
              const SizedBox(height: 12),
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
                  style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600, color: AppTheme.excelGreenDark),
                ),
              ),
            ],
            if (section.funFact != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.withOpacity(0.35)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💡', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(section.funFact!, style: const TextStyle(fontSize: 13, height: 1.4)),
                    ),
                  ],
                ),
              ),
            ],
            if (section.animationKey != null && conceptAnimations.containsKey(section.animationKey)) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => showConceptAnimation(context, conceptAnimations[section.animationKey]!(context)),
                  icon: const Icon(Icons.play_circle_fill_rounded, color: AppTheme.excelGreen),
                  label: const Text('Animation Dekho'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
