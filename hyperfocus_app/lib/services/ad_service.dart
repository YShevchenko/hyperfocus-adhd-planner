/// Stub AdService — ads removed to eliminate Firebase/Google dependency.
class AdService {
  static final AdService _instance = AdService._();
  factory AdService() => _instance;
  AdService._();

  bool isPremium = false;

  Future<void> initialize() async {}

  Future<void> preloadInterstitial() async {}

  Future<void> trackTaskCompletion() async {}

  void dispose() {}
}
