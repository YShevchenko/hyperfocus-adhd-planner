import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';

class ConsentService {
  static final ConsentService _instance = ConsentService._();
  factory ConsentService() => _instance;
  ConsentService._();

  bool _trackingAllowed = false;
  bool get trackingAllowed => _trackingAllowed;

  Future<void> requestTrackingPermission() async {
    if (!Platform.isIOS) {
      _trackingAllowed = true;
      return;
    }

    try {
      final status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        final result =
            await AppTrackingTransparency.requestTrackingAuthorization();
        _trackingAllowed = result == TrackingStatus.authorized;
      } else {
        _trackingAllowed = status == TrackingStatus.authorized;
      }
    } catch (e) {
      debugPrint('ATT request failed: $e');
      _trackingAllowed = false;
    }
  }
}
