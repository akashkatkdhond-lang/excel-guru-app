import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class _OnboardingSlide {
  final String emoji;
  final String title;
  final String description;
  const _OnboardingSlide({required this.emoji, required this.title, required this.description});
}

const _slides = [
  _OnboardingSlide(
    emoji: '📊',
    title: 'Excel Seekhein, Aasan Bhasha Me',
    description: 'Basics se advanced tak — VLOOKUP, Pivot Table, sab kuch step-by-step, Hinglish me samjhaya gaya.',
  ),
  _OnboardingSlide(
    emoji: '🧮',
    title: 'Khud Karke Seekhein',
    description: 'Practice Simulator me live formulas try karein — jaisa asli Excel me karte hain, waisa hi yahan.',
  ),
  _OnboardingSlide(
    emoji: '🏆',
    title: 'Streak Banayein, Certificate Paayein',
    description: 'Roz thoda seekhein, badges unlock karein, aur course complete karke apna certificate share karein.',
  ),
];

/// Shown once, on the very first app launch. Marks itself done in
/// SharedPreferences so it never appears again.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _slides.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(slide.emoji, style: const TextStyle(fontSize: 90)),
                        const SizedBox(height: 32),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          slide.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.4),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _page ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _page ? AppTheme.excelGreen : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLast
                      ? _finish
                      : () => _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                  child: Text(isLast ? 'Shuru Karein' : 'Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
