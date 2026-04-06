/// Stub ConsentService — ATT removed along with ads.
class ConsentService {
  static final ConsentService _instance = ConsentService._();
  factory ConsentService() => _instance;
  ConsentService._();

  bool get trackingAllowed => false;

  Future<void> requestTrackingPermission() async {}
}
