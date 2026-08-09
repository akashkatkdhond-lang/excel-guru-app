import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Central place for AdMob ad unit IDs and interstitial loading.
///
/// IMPORTANT: The IDs below are Google's official TEST ad unit IDs.
/// They are safe to use during development — replace them with YOUR
/// real AdMob ad unit IDs (from admob.google.com) before publishing,
/// otherwise you will earn no real revenue and risk a policy violation
/// if real ads are requested with test IDs (or vice versa).
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  // TODO: replace with your real Banner ad unit ID before release.
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  // TODO: replace with your real Interstitial ad unit ID before release.
  static const String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';

  InterstitialAd? _interstitialAd;
  int _lessonsViewedSinceLastAd = 0;

  Future<void> init() async {
    await MobileAds.instance.initialize();
    loadInterstitial();
  }

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  /// Call after a lesson/quiz is finished. Shows an interstitial every
  /// 3rd time to keep the app from feeling ad-heavy. Skipped entirely
  /// for premium users — call site should check ProgressService.isPremium.
  void maybeShowInterstitial() {
    _lessonsViewedSinceLastAd++;
    if (_lessonsViewedSinceLastAd < 3) return;
    if (_interstitialAd == null) return;

    _lessonsViewedSinceLastAd = 0;
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadInterstitial();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  BannerAd createBannerAd({required void Function() onLoaded}) {
    final banner = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => onLoaded(),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    );
    banner.load();
    return banner;
  }
}
