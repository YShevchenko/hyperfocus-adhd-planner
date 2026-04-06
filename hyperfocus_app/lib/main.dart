import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'services/ad_service.dart';
import 'services/chime_foreground_service.dart';
import 'services/consent_service.dart';
import 'services/iap_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Initialize foreground task communication port (must be before runApp).
  ChimeForegroundService.init();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  await _initializeServices();

  runApp(
    const ProviderScope(
      child: HyperFocusApp(),
    ),
  );
}

Future<void> _initializeServices() async {
  // Initialize ads
  await AdService().initialize();
  await AdService().preloadInterstitial();

  // Initialize IAP
  await IapService().initialize();

  // Request ATT (iOS)
  await ConsentService().requestTrackingPermission();

  // Sync premium status from IAP to AdService
  final iap = IapService();
  AdService().isPremium = iap.isPremium;
  iap.premiumStream.listen((isPremium) {
    AdService().isPremium = isPremium;
  });
}
