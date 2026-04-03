/// App-wide constants for HyperFocus.
class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'HyperFocus';
  static const String publisher = 'Heldig Lab';
  static const String contactEmail = 'heldig.lab@pm.me';
  static const String appVersion = '1.0.1';

  // IAP
  static const String premiumProductId = 'com.heldiglab.hyperfocus.premium';
  static const double premiumPrice = 14.99;

  // Ads
  static const int interstitialFrequency = 3; // every N task completions

  // AdMob IDs (test IDs — replace with real ones for production)
  static const String adMobAndroidAppId =
      'ca-app-pub-3940256099942544~3347511713';
  static const String adMobIosAppId =
      'ca-app-pub-3940256099942544~1458002511';
  static const String bannerAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String bannerAdUnitIdIos =
      'ca-app-pub-3940256099942544/2934735716';
  static const String interstitialAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String interstitialAdUnitIdIos =
      'ca-app-pub-3940256099942544/4411468910';

  // Database
  static const String databaseName = 'hyperfocus.db';
  static const int databaseVersion = 2;

  // Task categories
  static const List<String> categories = [
    'cleaning',
    'self_care',
    'admin',
    'work',
    'cooking',
    'social',
  ];

  // Time-blindness chime intervals (minutes)
  static const List<int> chimeIntervals = [5, 10, 15];

  // Default step duration (seconds)
  static const int defaultStepDurationSeconds = 120;

  // One Thing Mode text sizes
  static const double oneThingTextSize = 28.0;
  static const double oneThingStepCounterSize = 14.0;
}
