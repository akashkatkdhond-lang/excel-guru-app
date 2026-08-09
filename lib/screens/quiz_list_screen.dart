import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/quiz_data.dart';
import '../services/progress_service.dart';
import '../widgets/banner_ad_widget.dart';
import 'premium_screen.dart';
import 'quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: quizSets.length,
                itemBuilder: (context, index) {
                  final quiz = quizSets[index];
                  final isLocked = quiz.isPremium && !progress.isPremium;
                  final score = progress.getQuizScore(quiz.id);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrange.withOpacity(0.12),
                        child: const Icon(Icons.quiz_rounded, color: Colors.deepOrange),
                      ),
                      title: Text(quiz.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        '${quiz.questions.length} questions'
                        '${score != null ? ' • Best score: $score' : ''}',
                      ),
                      trailing: isLocked
                          ? const Icon(Icons.lock, color: Colors.grey)
                          : const Icon(Icons.chevron_right),
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
                          MaterialPageRoute(builder: (_) => QuizScreen(quiz: quiz)),
                        );
                      },
                    ),
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
