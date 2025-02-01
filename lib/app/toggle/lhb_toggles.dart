import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';
import 'package:littlehelpbook_flutter/app/config/app_config.dart';

class LhbToggles {
  LhbToggles._();

  static late GrowthBookSDK _client;

  static String? get alertMessage =>
      _client.feature('alert-message').value as String?;

  static String get appVersionHard =>
      _client.feature('app-version-hard') as String? ?? "1.0.0";

  static String get appVersionSoft =>
      _client.feature('app-version-soft') as String? ?? "1.0.0";

  static double get sentryProfilesSampleRate =>
      double.tryParse(
        _client.feature('sentry-profiles-sample-rate') as String,
      ) ??
      1.0;

  static double get sentryTracesSampleRate =>
      double.tryParse(_client.feature('sentry-traces-sample-rate') as String) ??
      1.0;

  /// Initialize the GrowthBook client and fetch all toggles.
  static Future<void> init() async {
    _client = await GBSDKBuilderApp(
      apiKey: AppConfig.growthBookApiKey,
      hostURL: AppConfig.growthBookHost,
      backgroundSync: true,
      growthBookTrackingCallBack: (data) {},
    ).initialize();
    await refresh();
  }

  /// Force a refresh of toggles from the server
  static Future<void> refresh() async {
    return await _client.refresh();
  }
}
