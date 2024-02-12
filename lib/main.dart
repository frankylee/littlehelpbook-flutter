import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/app.dart';
import 'package:littlehelpbook_flutter/app/config/app_config.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();

  await LhbToggles.shared.init();

  final app = await buildAppWithRiverpod(const LittleHelpBook());
  await openPowerSyncDatabase();

  // Initialize Sentry when not in debug mode.
  if (kDebugMode) {
    runApp(app);
  } else {
    await SentryFlutter.init(
      (options) {
        options.addIntegration(LoggingIntegration());
        options.attachScreenshot = true;
        options.dsn = AppConfig.sentryDsn;
        options.environment = AppConfig.flavor;
        options.profilesSampleRate = LhbToggles.sentryProfilesSampleRate;
        options.tracesSampleRate = LhbToggles.sentryTracesSampleRate;
      },
      appRunner: () => runApp(app),
    );
  }
}

/// Initialize the app with a [ProviderScope] and provider overrides.
Future<ProviderScope> buildAppWithRiverpod(Widget app) async {
  final providerScope = ProviderScope(
    child: app,
  );
  return providerScope;
}
