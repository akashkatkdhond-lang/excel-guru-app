import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = context.watch<LanguageService>();
    final themeService = context.watch<ThemeService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _OptionTile(
            title: 'Light',
            icon: Icons.light_mode,
            isSelected: themeService.themeMode == ThemeMode.light,
            onTap: () => themeService.setThemeMode(ThemeMode.light),
          ),
          const SizedBox(height: 8),
          _OptionTile(
            title: 'Dark',
            icon: Icons.dark_mode,
            isSelected: themeService.themeMode == ThemeMode.dark,
            onTap: () => themeService.setThemeMode(ThemeMode.dark),
          ),
          const SizedBox(height: 8),
          _OptionTile(
            title: 'System ke hisaab se',
            icon: Icons.brightness_auto,
            isSelected: themeService.themeMode == ThemeMode.system,
            onTap: () => themeService.setThemeMode(ThemeMode.system),
          ),
          const SizedBox(height: 28),
          const Text('Language / भाषा', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _OptionTile(
            title: 'Hinglish',
            subtitle: 'Hindi + English mix (default)',
            icon: Icons.translate,
            isSelected: languageService.language == AppLanguage.hinglish,
            onTap: () => languageService.setLanguage(AppLanguage.hinglish),
          ),
          const SizedBox(height: 8),
          _OptionTile(
            title: 'मराठी',
            subtitle: 'Marathi',
            icon: Icons.translate,
            isSelected: languageService.language == AppLanguage.marathi,
            onTap: () => languageService.setLanguage(AppLanguage.marathi),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
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
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.excelGreen) : null,
        onTap: onTap,
      ),
    );
  }
}
