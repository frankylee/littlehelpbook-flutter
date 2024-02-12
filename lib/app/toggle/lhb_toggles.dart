import 'package:littlehelpbook_flutter/app/config/app_config.dart';
import 'package:uptech_growthbook_sdk_flutter/uptech_growthbook_sdk_flutter.dart';

class LhbToggles extends UptechGrowthBookWrapper {
  LhbToggles()
      : super(
          apiHost: AppConfig.growthBookHost,
          clientKey: AppConfig.growthBookApiKey,
        );

  static final shared = LhbToggles();

  static String? get alertMessage => shared.value('alert-message') as String?;

  static String get appVersionHard =>
      shared.value('app-version-hard') as String? ?? "1.0.0";

  static String get appVersionSoft =>
      shared.value('app-version-soft') as String? ?? "1.0.0";

  static double get sentryProfilesSampleRate =>
      double.tryParse(shared.value('sentry-profiles-sample-rate') as String) ??
      1.0;

  static double get sentryTracesSampleRate =>
      double.tryParse(shared.value('sentry-traces-sample-rate') as String) ??
      1.0;
}
