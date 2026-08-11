import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/levels_data.dart';
import '../models/excel_level.dart';
import '../services/ad_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import 'premium_screen.dart';

class LevelDetailScreen extends StatefulWidget {
  const LevelDetailScreen({super.key, required this.level});
  final ExcelLevel level;

  @override
  State<LevelDetailScreen> createState() => _LevelDetailScreenState();
}

class _LevelDetailScreenState extends State<LevelDetailScreen> {
  bool _completed = false;

  ExcelLevel? get _nextLevel {
    final nextNumber = widget.level.number + 1;
    try {
      return excelLevels.firstWhere((l) => l.number == nextNumber);
    } catch (_) {
      return null;
    }
  }

  Future<void> _completeAndContinue() async {
    final progress = context.read<ProgressService>();
    await progress.markLevelComplete(widget.level.number);
    if (!progress.isPremium) AdService.instance.maybeShowInterstitial();
    setState(() => _completed = true);

    final next = _nextLevel;
    if (next == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 Bahut Badhiya!'),
          content: const Text('Aapne sabhi 50 levels complete kar liye — aap ab Excel Expert hain!'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst), child: const Text('OK')),
          ],
        ),
      );
      return;
    }

    if (next.isPremium && !progress.isPremium) {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PremiumScreen()));
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LevelDetailScreen(level: next)));
  }

  @override
  Widget build(BuildContext context) {
    final level = widget.level;
    return Scaffold(
      appBar: AppBar(title: Text('Level ${level.number}')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.excelGreen.withOpacity(0.12),
                    child: Text('${level.number}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(level.category,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  if (level.isPremium)
                    const Icon(Icons.workspace_premium, color: AppTheme.accent, size: 20),
                ],
              ),
              const SizedBox(height: 16),
              Text(level.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 14),
              Text(level.explanation, style: const TextStyle(fontSize: 15, height: 1.5)),
              if (level.formulaExample != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.excelGreen.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.excelGreen.withOpacity(0.3)),
                  ),
                  child: Text(
                    level.formulaExample!,
                    style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _completed ? null : _completeAndContinue,
                  icon: Icon(_completed ? Icons.check : Icons.arrow_forward),
                  label: Text(_nextLevel == null ? 'Complete Karein — Final Level!' : 'Complete & Next Level'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
