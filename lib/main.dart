import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'services/ad_service.dart';
import 'services/language_service.dart';
import 'services/progress_service.dart';
import 'services/purchase_service.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final progressService = ProgressService();
  await progressService.init();
  await AdService.instance.init();

  final purchaseService = PurchaseService(progressService);
  await purchaseService.init();

  final languageService = LanguageService();
  await languageService.init();

  final themeService = ThemeService();
  await themeService.init();

  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

  runApp(ExcelGuruApp(
    progressService: progressService,
    purchaseService: purchaseService,
    languageService: languageService,
    themeService: themeService,
    showOnboarding: !hasSeenOnboarding,
  ));
}

class ExcelGuruApp extends StatelessWidget {
  const ExcelGuruApp({
    super.key,
    required this.progressService,
    required this.purchaseService,
    required this.languageService,
    required this.themeService,
    required this.showOnboarding,
  });

  final ProgressService progressService;
  final PurchaseService purchaseService;
  final LanguageService languageService;
  final ThemeService themeService;
  final bool showOnboarding;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressService),
        Provider.value(value: purchaseService),
        ChangeNotifierProvider.value(value: languageService),
        ChangeNotifierProvider.value(value: themeService),
      ],
      // Builder gives us a context that sits BELOW MultiProvider, so
      // context.watch here can actually see ThemeService and rebuild
      // MaterialApp when the theme changes.
      child: Builder(
        builder: (context) {
          final theme = context.watch<ThemeService>();
          return MaterialApp(
            title: 'Excel Guru',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: theme.themeMode,
            home: showOnboarding ? const OnboardingScreen() : const HomeScreen(),
          );
        },
      ),
    );
  }
}
