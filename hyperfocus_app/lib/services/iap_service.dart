import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../core/constants.dart';

class IapService {
  static final IapService _instance = IapService._();
  factory IapService() => _instance;
  IapService._();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _isPremium = false;
  ProductDetails? _premiumProduct;

  final _premiumController = StreamController<bool>.broadcast();
  Stream<bool> get premiumStream => _premiumController.stream;
  bool get isPremium => _isPremium;
  ProductDetails? get premiumProduct => _premiumProduct;

  Future<void> initialize() async {
    final available = await _iap.isAvailable();
    if (!available) {
      debugPrint('IAP not available');
      return;
    }

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (error) {
        debugPrint('IAP purchase stream error: $error');
      },
    );

    // Load products
    final response = await _iap.queryProductDetails(
      {AppConstants.premiumProductId},
    );

    if (response.productDetails.isNotEmpty) {
      _premiumProduct = response.productDetails.first;
    }

    // Check for existing purchases
    await restorePurchases();
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.productID == AppConstants.premiumProductId) {
        switch (purchase.status) {
          case PurchaseStatus.purchased:
          case PurchaseStatus.restored:
            _isPremium = true;
            _premiumController.add(true);
            if (purchase.pendingCompletePurchase) {
              _iap.completePurchase(purchase);
            }
            break;
          case PurchaseStatus.error:
            debugPrint('Purchase error: ${purchase.error}');
            if (purchase.pendingCompletePurchase) {
              _iap.completePurchase(purchase);
            }
            break;
          case PurchaseStatus.pending:
            break;
          case PurchaseStatus.canceled:
            if (purchase.pendingCompletePurchase) {
              _iap.completePurchase(purchase);
            }
            break;
        }
      }
    }
  }

  Future<bool> purchasePremium() async {
    if (_premiumProduct == null) return false;

    final purchaseParam = PurchaseParam(
      productDetails: _premiumProduct!,
    );

    try {
      return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint('Purchase failed: $e');
      return false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      debugPrint('Restore purchases failed: $e');
    }
  }

  void dispose() {
    _subscription?.cancel();
    _premiumController.close();
  }
}
