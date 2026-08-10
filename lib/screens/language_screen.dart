import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = context.watch<LanguageService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Language / भाषा')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Lessons aur Quiz kis bhasha me dikhein?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          _LanguageOption(
            title: 'Hinglish',
            subtitle: 'Hindi + English mix (default)',
            isSelected: languageService.language == AppLanguage.hinglish,
            onTap: () => languageService.setLanguage(AppLanguage.hinglish),
          ),
          const SizedBox(height: 12),
          _LanguageOption(
            title: 'मराठी',
            subtitle: 'Marathi',
            isSelected: languageService.language == AppLanguage.marathi,
            onTap: () => languageService.setLanguage(AppLanguage.marathi),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppTheme.excelGreen.withOpacity(0.08) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: isSelected ? AppTheme.excelGreen : Colors.transparent, width: 1.5),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.excelGreen) : null,
        onTap: onTap,
      ),
    );
  }
}
