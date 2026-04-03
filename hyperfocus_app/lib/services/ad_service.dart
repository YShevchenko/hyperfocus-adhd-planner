import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/constants.dart';

class AdService {
  static final AdService _instance = AdService._();
  factory AdService() => _instance;
  AdService._();

  bool _initialized = false;
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  int _completionCount = 0;
  bool isPremium = false;

  String get _bannerAdUnitId => Platform.isAndroid
      ? AppConstants.bannerAdUnitIdAndroid
      : AppConstants.bannerAdUnitIdIos;

  String get _interstitialAdUnitId => Platform.isAndroid
      ? AppConstants.interstitialAdUnitIdAndroid
      : AppConstants.interstitialAdUnitIdIos;

  Future<void> initialize() async {
    if (_initialized) return;
    await MobileAds.instance.initialize();
    _initialized = true;
  }

  /// Load a banner ad. Returns the BannerAd or null if premium.
  BannerAd? loadBannerAd() {
    if (isPremium) return null;

    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          debugPrint('Banner ad failed to load: $error');
        },
      ),
    )..load();
    return _bannerAd;
  }

  /// Track task completion and show interstitial if threshold reached.
  Future<void> trackTaskCompletion() async {
    if (isPremium) return;
    _completionCount++;
    if (_completionCount >= AppConstants.interstitialFrequency) {
      _completionCount = 0;
      await _showInterstitial();
    }
  }

  Future<void> _loadInterstitial() async {
    await InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _loadInterstitial();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  Future<void> _showInterstitial() async {
    if (_interstitialAd != null) {
      await _interstitialAd!.show();
    } else {
      await _loadInterstitial();
    }
  }

  /// Pre-load interstitial after initialization.
  Future<void> preloadInterstitial() async {
    if (!isPremium) {
      await _loadInterstitial();
    }
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}
