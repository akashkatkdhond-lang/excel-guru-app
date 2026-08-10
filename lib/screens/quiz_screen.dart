import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quiz_question.dart';
import '../services/ad_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quiz});
  final QuizSet quiz;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;

  QuizQuestion get _question => widget.quiz.questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex == widget.quiz.questions.length - 1;

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _question.correctIndex) _score++;
    });
  }

  void _next() {
    if (_isLastQuestion) {
      final progress = context.read<ProgressService>();
      progress.saveQuizScore(widget.quiz.id, _score, widget.quiz.questions.length);
      if (!progress.isPremium) AdService.instance.maybeShowInterstitial();
      _showResultDialog();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedOption = null;
      _answered = false;
    });
  }

  void _shareScore() {
    final total = widget.quiz.questions.length;
    Share.share(
      'Maine "${widget.quiz.title}" quiz me $_score/$total score kiya Excel Guru app par! 🎉 '
      'Tum bhi Excel seekho: https://play.google.com/store',
    );
  }

  void _showResultDialog() {
    final total = widget.quiz.questions.length;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Complete! 🎉'),
        content: Text('Aapka score: $_score / $total'),
        actions: [
          TextButton(
            onPressed: _shareScore,
            child: const Text('Share'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _question;
    return Scaffold(
      appBar: AppBar(title: Text(widget.quiz.title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.quiz.questions.length,
                backgroundColor: Colors.grey.shade300,
                color: AppTheme.excelGreen,
              ),
              const SizedBox(height: 8),
              Text('Question ${_currentIndex + 1} / ${widget.quiz.questions.length}',
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Text(q.question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: q.options.length,
                  itemBuilder: (context, index) {
                    final isCorrect = index == q.correctIndex;
                    final isSelected = index == _selectedOption;
                    Color? bg;
                    if (_answered) {
                      if (isCorrect) {
                        bg = Colors.green.withOpacity(0.15);
                      } else if (isSelected) {
                        bg = Colors.red.withOpacity(0.15);
                      }
                    }
                    return Card(
                      color: bg,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(q.options[index]),
                        trailing: _answered && isCorrect
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : (_answered && isSelected
                                ? const Icon(Icons.cancel, color: Colors.red)
                                : null),
                        onTap: () => _selectOption(index),
                      ),
                    );
                  },
                ),
              ),
              if (_answered) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(q.explanation),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    child: Text(_isLastQuestion ? 'Finish' : 'Next Question'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
