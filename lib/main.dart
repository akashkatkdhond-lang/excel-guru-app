import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/ad_service.dart';
import 'services/language_service.dart';
import 'services/progress_service.dart';
import 'services/purchase_service.dart';
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

  runApp(ExcelGuruApp(
    progressService: progressService,
    purchaseService: purchaseService,
    languageService: languageService,
  ));
}

class ExcelGuruApp extends StatelessWidget {
  const ExcelGuruApp({
    super.key,
    required this.progressService,
    required this.purchaseService,
    required this.languageService,
  });

  final ProgressService progressService;
  final PurchaseService purchaseService;
  final LanguageService languageService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressService),
        Provider.value(value: purchaseService),
        ChangeNotifierProvider.value(value: languageService),
      ],
      child: MaterialApp(
        title: 'Excel Guru',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
