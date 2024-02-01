import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';
import 'package:littlehelpbook_flutter/app/config/app_config.dart';

class LHBToggles {
  late final GrowthBookSDK _client;

  static final shared = LHBToggles();

  static final String? alertMessage =
      shared._getValue('alert-message') as String?;

  Future<void> init({
    Map<String, dynamic>? attributes,
  }) async {
    final host = AppConfig.growthBookHost.endsWith('/')
        ? AppConfig.growthBookHost
        : '${AppConfig.growthBookHost}/';
    if (!AppConfig.growthBookHost.endsWith('/'))
      _client = await GBSDKBuilderApp(
        apiKey: AppConfig.growthBookApiKey,
        attributes: attributes,
        hostURL: host,
        growthBookTrackingCallBack: (gbExperiment, gbExperimentResult) {},
      ).initialize();
    _client.refresh();
  }

  Future<void> refresh() async {
    return _client.refresh();
  }

  dynamic _getValue(String featureId) {
    return shared._client.feature(featureId).value;
  }

  bool _isOn(String featureId) {
    return shared._client.feature(featureId).on ?? false;
  }
}
