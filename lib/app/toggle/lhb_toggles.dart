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
      shared.value('app-version-hard') as String;

  static String get appVersionSoft =>
      shared.value('app-version-soft') as String;
}
