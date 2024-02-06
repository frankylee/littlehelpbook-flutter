import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/app.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();

  await LhbToggles.shared.init();

  final app = await buildAppWithRiverpod(const LittleHelpBook());
  await openPowerSyncDatabase();
  runApp(app);
}

/// Initialize the app with a [ProviderScope] and provider overrides.
Future<ProviderScope> buildAppWithRiverpod(Widget app) async {
  final providerScope = ProviderScope(
    child: app,
  );
  return providerScope;
}
