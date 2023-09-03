import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/common/router/lhb_router.dart';
import 'package:littlehelpbook_flutter/data/powersync/powersync.dart';
import 'package:littlehelpbook_flutter/generated/l10n.dart';
import 'package:littlehelpbook_flutter/theme/lhb_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();

  final app = await buildAppWithRiverpod(const MyApp());
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Little Help Book',
      theme: LittleHelpBookTheme.lightTheme,
      darkTheme: LittleHelpBookTheme.darkTheme,
      localizationsDelegates: const [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: lhbRouter,
    );
  }
}
