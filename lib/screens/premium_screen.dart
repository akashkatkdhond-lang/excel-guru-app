import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import '../services/progress_service.dart';
import '../services/purchase_service.dart';
import '../theme/app_theme.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  ProductDetails? _product;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final purchaseService = context.read<PurchaseService>();
      final response = await purchaseService.queryProducts();
      if (response.notFoundIDs.isNotEmpty || response.productDetails.isEmpty) {
        setState(() {
          _error = 'Product Play Console me abhi set up nahi hua (dev mode).';
          _loading = false;
        });
        return;
      }
      setState(() {
        _product = response.productDetails.first;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Store se connect nahi ho paya. Play Store build me test karein.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = context.watch<ProgressService>().isPremium;

    return Scaffold(
      appBar: AppBar(title: const Text('Go Premium')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.workspace_premium_rounded, color: AppTheme.accent, size: 64),
              const SizedBox(height: 16),
              const Text('Excel Guru Premium',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const _BenefitRow(text: 'Sabhi ads hamesha ke liye hat jayenge'),
              const _BenefitRow(text: 'Advanced lessons unlock: VLOOKUP, Pivot Table, Charts'),
              const _BenefitRow(text: 'Advanced quiz sets unlock'),
              const Spacer(),
              if (isPremium)
                const Text('✅ Aap already Premium member hain — Dhanyavaad!',
                    style: TextStyle(color: AppTheme.excelGreen, fontWeight: FontWeight.bold))
              else if (_loading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red))
              else if (_product != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.read<PurchaseService>().buyPremium(_product!),
                    child: Text('Unlock for ${_product!.price}'),
                  ),
                ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.read<PurchaseService>().restorePurchases(),
                child: const Text('Restore purchase'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppTheme.excelGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
