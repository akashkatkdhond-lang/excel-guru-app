import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'progress_service.dart';

/// Handles the one-time "Remove Ads / Unlock Premium Lessons" purchase.
///
/// Setup required in Play Console before this works:
/// 1. Create an in-app product with ID [premiumProductId] (one-time, managed).
/// 2. Set a price, publish it, and upload a signed build with billing
///    permission for the product to become purchasable (test with a
///    License Tester account first).
class PurchaseService {
  PurchaseService(this._progress);

  final ProgressService _progress;
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  static const String premiumProductId = 'excel_guru_premium_unlock';

  Future<void> init() async {
    final available = await _iap.isAvailable();
    if (!available) return;

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (_) {},
    );
  }

  Future<ProductDetailsResponse> queryProducts() {
    return _iap.queryProductDetails({premiumProductId});
  }

  Future<void> buyPremium(ProductDetails product) async {
    final purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() => _iap.restorePurchases();

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        if (purchase.productID == premiumProductId) {
          _progress.setPremium(true);
        }
        if (purchase.pendingCompletePurchase) {
          _iap.completePurchase(purchase);
        }
      } else if (purchase.status == PurchaseStatus.error) {
        if (purchase.pendingCompletePurchase) {
          _iap.completePurchase(purchase);
        }
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
