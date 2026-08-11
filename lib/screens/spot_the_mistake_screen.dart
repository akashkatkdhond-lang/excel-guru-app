import 'package:flutter/material.dart';
import '../data/mistakes_data.dart';
import '../models/mistake_challenge.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_ad_widget.dart';

/// Quick 30-second engagement mini-game: shows a broken formula/setup,
/// user finds the mistake. Free for everyone — pure engagement feature.
class SpotTheMistakeScreen extends StatefulWidget {
  const SpotTheMistakeScreen({super.key});

  @override
  State<SpotTheMistakeScreen> createState() => _SpotTheMistakeScreenState();
}

class _SpotTheMistakeScreenState extends State<SpotTheMistakeScreen> {
  late List<MistakeChallenge> _shuffled;
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _shuffled = List.of(mistakeChallenges)..shuffle();
  }

  MistakeChallenge get _current => _shuffled[_index];
  bool get _isLast => _index == _shuffled.length - 1;

  void _select(int i) {
    if (_answered) return;
    setState(() {
      _selected = i;
      _answered = true;
      if (i == _current.correctIndex) _score++;
    });
  }

  void _next() {
    if (_isLast) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Game Over! 🔍'),
          content: Text('Aapne $_score / ${_shuffled.length} mistakes sahi pakadi!'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Band Karein')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _shuffled = List.of(mistakeChallenges)..shuffle();
                  _index = 0;
                  _score = 0;
                  _selected = null;
                  _answered = false;
                });
              },
              child: const Text('Phir Se Khelein'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = _current;
    return Scaffold(
      appBar: AppBar(title: const Text('🔍 Spot the Mistake')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Round ${_index + 1} / ${_shuffled.length}', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 12),
                    Text(c.scenario, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Text(c.shownFormula, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    const Text('Yahan kya galat hai?', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    for (var i = 0; i < c.options.length; i++) _buildOption(c, i),
                    if (_answered) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(c.explanation),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_answered)
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    child: Text(_isLast ? 'Finish' : 'Next Round'),
                  ),
                ),
              ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(MistakeChallenge c, int i) {
    final isCorrect = i == c.correctIndex;
    final isSelected = i == _selected;
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
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(c.options[i]),
        trailing: _answered && isCorrect
            ? const Icon(Icons.check_circle, color: AppTheme.excelGreen)
            : (_answered && isSelected ? const Icon(Icons.cancel, color: Colors.red) : null),
        onTap: () => _select(i),
      ),
    );
  }
}
