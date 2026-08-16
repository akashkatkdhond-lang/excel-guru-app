import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/daily_challenges_data.dart';
import '../models/daily_challenge.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';

/// A new challenge unlocks every calendar day — same one for every user
/// that day (Wordle-style), picked deterministically so no server/backend
/// is needed. Free for everyone; drives the daily-return habit.
class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> with SingleTickerProviderStateMixin {
  int? _selected;
  bool _answered = false;
  bool _wasCorrect = false;
  late AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  DailyChallenge get _todayChallenge {
    final progress = context.read<ProgressService>();
    final index = progress.challengeIndexFor(DateTime.now(), dailyChallenges.length);
    return dailyChallenges[index];
  }

  void _select(int i, ProgressService progress) {
    if (_answered) return;
    final correct = i == _todayChallenge.correctIndex;
    setState(() {
      _selected = i;
      _answered = true;
      _wasCorrect = correct;
    });
    if (correct) {
      progress.markTodayChallengeDone();
      _confettiController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final alreadyDoneToday = progress.isTodayChallengeDone;

    return Scaffold(
      appBar: AppBar(title: const Text('🔥 Daily Challenge')),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StreakHeader(progress: progress),
                        const SizedBox(height: 16),
                        _WeekStrip(progress: progress),
                        const SizedBox(height: 20),
                        if (alreadyDoneToday && !_answered) _AlreadyDoneCard(challenge: _todayChallenge) else _buildChallengeCard(progress),
                      ],
                    ),
                  ),
                ),
                const BannerAdWidget(),
              ],
            ),
            if (_answered && _wasCorrect)
              IgnorePointer(
                child: AnimatedBuilder(
                  animation: _confettiController,
                  builder: (context, _) => CustomPaint(
                    size: Size.infinite,
                    painter: _ConfettiPainter(_confettiController.value),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(ProgressService progress) {
    final c = _todayChallenge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Aaj ka Challenge', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(c.prompt, style: const TextStyle(fontSize: 15, height: 1.4)),
        if (c.formulaOrScenario != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.excelGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.excelGreen.withOpacity(0.3)),
            ),
            child: Text(c.formulaOrScenario!, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
          ),
        ],
        const SizedBox(height: 18),
        for (var i = 0; i < c.options.length; i++) _buildOption(c, i, progress),
        if (_answered) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: (_wasCorrect ? AppTheme.excelGreen : Colors.red).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _wasCorrect ? '🎉 Sahi jawab! Streak badh gaya.' : 'Koi baat nahi, agli baar sahi karenge!',
                  style: TextStyle(fontWeight: FontWeight.bold, color: _wasCorrect ? AppTheme.excelGreenDark : Colors.red.shade700),
                ),
                const SizedBox(height: 6),
                Text(c.explanation, style: const TextStyle(height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kal ek naya challenge unlock hoga — wapas aana mat bhoolna! 📅',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildOption(DailyChallenge c, int i, ProgressService progress) {
    final isCorrect = i == c.correctIndex;
    final isSelected = i == _selected;
    Color? bg;
    if (_answered) {
      if (isCorrect) {
        bg = AppTheme.excelGreen.withOpacity(0.15);
      } else if (isSelected) {
        bg = Colors.red.withOpacity(0.15);
      }
    }
    return Card(
      color: bg,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(c.options[i]),
        trailing: _answered && isCorrect
            ? const Icon(Icons.check_circle, color: AppTheme.excelGreen)
            : (_answered && isSelected ? const Icon(Icons.cancel, color: Colors.red) : null),
        onTap: () => _select(i, progress),
      ),
    );
  }
}

class _StreakHeader extends StatelessWidget {
  const _StreakHeader({required this.progress});
  final ProgressService progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF7A18), Color(0xFFE84545)]),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${progress.dailyChallengeStreak} din ka streak',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Roz ek naya challenge solve karein', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip({required this.progress});
  final ProgressService progress;

  static const _dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    final days = progress.lastSevenDaysChallengeStatus();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((entry) {
        final date = entry.key;
        final done = entry.value;
        final isToday = DateTime.now().difference(date).inDays == 0 && DateTime.now().day == date.day;
        return Column(
          children: [
            Text(_dayLabels[date.weekday % 7], style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: done ? AppTheme.excelGreen : Colors.grey.withOpacity(0.15),
                shape: BoxShape.circle,
                border: isToday ? Border.all(color: AppTheme.accent, width: 2) : null,
              ),
              child: done
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text('${date.day}', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _AlreadyDoneCard extends StatelessWidget {
  const _AlreadyDoneCard({required this.challenge});
  final DailyChallenge challenge;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.excelGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.excelGreen.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle, color: AppTheme.excelGreen),
              SizedBox(width: 8),
              Expanded(
                child: Text('Aaj ka challenge complete ho gaya! ✅', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(challenge.prompt, style: const TextStyle(height: 1.4)),
          const SizedBox(height: 10),
          Text(challenge.explanation, style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.4)),
          const SizedBox(height: 12),
          Text('Kal ek naya challenge unlock hoga — tab tak ke liye badhai! 🎉',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }
}

/// Lightweight hand-rolled confetti burst — no extra package dependency.
/// Draws ~24 small rectangles falling + rotating from the top of the
/// screen, faded out towards the end of the animation.
class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.progress);
  final double progress;

  static final _random = Random(7);
  static final List<_ConfettiPiece> _pieces = List.generate(24, (i) {
    return _ConfettiPiece(
      x: _random.nextDouble(),
      delay: _random.nextDouble() * 0.3,
      color: [
        AppTheme.excelGreen,
        AppTheme.accent,
        Colors.pinkAccent,
        Colors.blueAccent,
        Colors.orangeAccent,
      ][i % 5],
      rotationSpeed: (_random.nextDouble() - 0.5) * 8,
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final piece in _pieces) {
      final localProgress = ((progress - piece.delay) / (1 - piece.delay)).clamp(0.0, 1.0);
      if (localProgress <= 0) continue;
      final dx = piece.x * size.width;
      final dy = localProgress * (size.height * 0.5);
      final opacity = (1 - localProgress).clamp(0.0, 1.0);

      final paint = Paint()..color = piece.color.withOpacity(opacity);
      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(localProgress * piece.rotationSpeed);
      canvas.drawRect(const Rect.fromLTWH(-4, -6, 8, 12), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}

class _ConfettiPiece {
  _ConfettiPiece({required this.x, required this.delay, required this.color, required this.rotationSpeed});
  final double x;
  final double delay;
  final Color color;
  final double rotationSpeed;
}
