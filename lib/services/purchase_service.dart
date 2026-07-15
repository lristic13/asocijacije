import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// RevenueCat wrapper for the one-time "pro" unlock (custom words).
///
/// The SDK is only configured when a real API key is present, so the app
/// keeps working before the store setup is finished — everything degrades
/// to "not pro" (except in debug builds, see [PaywallPage] debug unlock).
class PurchaseService {
  PurchaseService._();

  // Public SDK keys from RevenueCat → Project settings → API keys.
  static const String _appleApiKey = 'appl_REPLACE_ME';
  static const String _googleApiKey = 'goog_REPLACE_ME';

  static const String entitlementId = 'pro';

  static bool _configured = false;
  static bool get isConfigured => _configured;

  static String get _apiKey =>
      Platform.isIOS ? _appleApiKey : _googleApiKey;

  /// Configures the SDK and starts listening for entitlement changes.
  /// [onProChanged] fires with the current status immediately after
  /// configuration and again on every purchase/restore/renewal event.
  static Future<void> init({
    required void Function(bool isPro) onProChanged,
  }) async {
    if (_apiKey.contains('REPLACE_ME')) {
      debugPrint('PurchaseService: no API key set, skipping configuration');
      return;
    }

    try {
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
      await Purchases.configure(PurchasesConfiguration(_apiKey));
      _configured = true;

      Purchases.addCustomerInfoUpdateListener(
        (info) => onProChanged(_hasPro(info)),
      );

      final info = await Purchases.getCustomerInfo();
      onProChanged(_hasPro(info));
    } catch (e) {
      debugPrint('PurchaseService: configuration failed: $e');
    }
  }

  static bool _hasPro(CustomerInfo info) =>
      info.entitlements.active.containsKey(entitlementId);

  /// Localized price of the lifetime package (e.g. "€3,99"), or null if
  /// offerings can't be loaded (offline, not configured yet).
  static Future<String?> getProPrice() async {
    if (!_configured) return null;
    try {
      final offerings = await Purchases.getOfferings();
      return _proPackage(offerings)?.storeProduct.priceString;
    } catch (e) {
      debugPrint('PurchaseService: failed to load offerings: $e');
      return null;
    }
  }

  static Package? _proPackage(Offerings offerings) {
    final current = offerings.current;
    if (current == null) return null;
    return current.lifetime ?? current.availablePackages.firstOrNull;
  }

  /// Starts the purchase flow. Returns true if the user ends up entitled.
  /// Returns false on cancellation or failure.
  static Future<bool> purchasePro() async {
    if (!_configured) return false;
    try {
      final offerings = await Purchases.getOfferings();
      final package = _proPackage(offerings);
      if (package == null) return false;

      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _hasPro(result.customerInfo);
    } on PurchasesError catch (e) {
      if (e.code != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('PurchaseService: purchase failed: ${e.code}');
      }
      return false;
    } catch (e) {
      debugPrint('PurchaseService: purchase failed: $e');
      return false;
    }
  }

  /// Restores previous purchases. Returns true if the entitlement is active
  /// after restoring.
  static Future<bool> restorePurchases() async {
    if (!_configured) return false;
    try {
      final info = await Purchases.restorePurchases();
      return _hasPro(info);
    } catch (e) {
      debugPrint('PurchaseService: restore failed: $e');
      return false;
    }
  }
}
