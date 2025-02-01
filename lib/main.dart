import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/app.dart';
import 'package:littlehelpbook_flutter/app/config/app_config.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';
import 'package:littlehelpbook_flutter/logger.dart';
import 'package:littlehelpbook_flutter/shared/extensions/map_ext.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';
import 'package:logging/logging.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  _initializeLogging();

  await LhbToggles.init();

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

/// Initialize logging, if appropriate.
void _initializeLogging() {
  Loggy.initLoggy(
    logPrinter:
        kDebugMode ? const PrettyDeveloperPrinter() : const DefaultPrinter(),
    hierarchicalLogging: true,
  );
  Logger.root.level = AppConfig.isProduction ? Level.OFF : Level.INFO;
  Logger.root.onRecord.listen((record) {
    final level = logLevelMap.getOrDefault(record.level, LogLevel.info);

    final loggerName = record.loggerName.isEmpty ? 'App' : record.loggerName;

    Loggy(loggerName).log(
      level,
      record.message,
      record.error,
      record.stackTrace,
      record.zone,
    );
  });

  FlutterError.onError = (details) {
    logError(details.exceptionAsString(), details.exception, details.stack);
  };
}
