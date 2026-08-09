import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/ad_service.dart';
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

  runApp(ExcelGuruApp(
    progressService: progressService,
    purchaseService: purchaseService,
  ));
}

class ExcelGuruApp extends StatelessWidget {
  const ExcelGuruApp({
    super.key,
    required this.progressService,
    required this.purchaseService,
  });

  final ProgressService progressService;
  final PurchaseService purchaseService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressService),
        Provider.value(value: purchaseService),
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
