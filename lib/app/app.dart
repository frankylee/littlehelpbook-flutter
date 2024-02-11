import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_router.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_theme.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/generated/l10n.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LittleHelpBook extends ConsumerWidget {
  const LittleHelpBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(userPreferencesProvider).maybeWhen(
          data: (data) => data.appTheme,
          orElse: () => ThemeMode.system,
        );
    return ResponsiveApp(
      builder: (context) => MaterialApp.router(
        title: 'Little Help Book',
        theme: LittleHelpBookTheme.lightTheme,
        darkTheme: LittleHelpBookTheme.darkTheme,
        themeMode: appThemeMode,
        localizationsDelegates: const [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: lhbRouter,
      ),
    );
  }
}
