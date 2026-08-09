// Basic smoke test — verifies the app boots and the Home screen renders
// without throwing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:excel_guru/screens/home_screen.dart';
import 'package:excel_guru/services/progress_service.dart';
import 'package:excel_guru/services/purchase_service.dart';

void main() {
  testWidgets('Home screen shows app title and menu items', (WidgetTester tester) async {
    final progressService = ProgressService();
    await progressService.init();
    final purchaseService = PurchaseService(progressService);

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressService),
        Provider.value(value: purchaseService),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) => const _TestHome(),
        ),
      ),
    ));

    expect(find.text('Excel Guru'), findsWidgets);
    expect(find.text('Lessons'), findsOneWidget);
    expect(find.text('Quiz'), findsOneWidget);
  });
}

// Re-uses the real Home screen widget without re-running main()'s async init.
class _TestHome extends StatelessWidget {
  const _TestHome();

  @override
  Widget build(BuildContext context) => const HomeScreen();
}
