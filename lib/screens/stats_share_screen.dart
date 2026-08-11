import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../data/badges_data.dart';
import '../data/lessons_data.dart';
import '../data/levels_data.dart';
import '../services/language_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';

/// A "Spotify Wrapped"-style shareable stats card — free, pure growth
/// feature. The more people share this, the more organic installs.
class StatsShareScreen extends StatefulWidget {
  const StatsShareScreen({super.key});

  @override
  State<StatsShareScreen> createState() => _StatsShareScreenState();
}

class _StatsShareScreenState extends State<StatsShareScreen> {
  final GlobalKey _cardKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _share() async {
    setState(() => _isSharing = true);
    try {
      final boundary = _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/excel_guru_stats.png');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Excel Guru app par meri progress dekho! 🚀 Aap bhi Excel free me seekho.',
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final language = context.watch<LanguageService>().language;
    final totalLessons = lessonsFor(language).length;
    final badgeCount = progress.unlockedBadgeIds(totalLessonCount: totalLessons).length;
    final levelsDone = progress.completedLevels.length;
    final levelLabel = progress.currentLevelLabel(totalLessonCount: totalLessons);

    return Scaffold(
      appBar: AppBar(title: const Text('Meri Progress Share Karein')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              RepaintBoundary(
                key: _cardKey,
                child: _StatsCard(
                  levelLabel: levelLabel,
                  streak: progress.currentStreak,
                  levelsDone: levelsDone,
                  totalLevels: excelLevels.length,
                  badgeCount: badgeCount,
                  totalBadges: allBadges.length,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSharing ? null : _share,
                  icon: _isSharing
                      ? const SizedBox(
                          width: 16, height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.share),
                  label: Text(_isSharing ? 'Taiyaar ho raha hai...' : 'Share Karein'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.levelLabel,
    required this.streak,
    required this.levelsDone,
    required this.totalLevels,
    required this.badgeCount,
    required this.totalBadges,
  });

  final String levelLabel;
  final int streak;
  final int levelsDone;
  final int totalLevels;
  final int badgeCount;
  final int totalBadges;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.excelGreen, AppTheme.excelGreenDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text('📊 EXCEL GURU', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 14)),
          const SizedBox(height: 4),
          const Text('Meri Progress', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 24),
          Text(levelLabel, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(emoji: '🔥', value: '$streak', label: 'Din Streak'),
              _StatItem(emoji: '🪜', value: '$levelsDone/$totalLevels', label: 'Levels'),
              _StatItem(emoji: '🏅', value: '$badgeCount/$totalBadges', label: 'Badges'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.emoji, required this.value, required this.label});
  final String emoji;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}
