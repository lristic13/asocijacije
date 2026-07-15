/// Compile-time feature switches.
class FeatureFlags {
  /// Gates custom words behind the lifetime "pro" purchase.
  /// Flip to true once the store products and RevenueCat keys are live.
  /// While false, custom words stay free and the RevenueCat SDK is never
  /// configured.
  static const bool paywallEnabled = false;
}
