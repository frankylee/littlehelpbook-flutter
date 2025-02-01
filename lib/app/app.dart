import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/littlehelpbook_l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_router.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_theme.dart';
import 'package:littlehelpbook_flutter/app/toggle/refresh_toggles_provider.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LittleHelpBook extends ConsumerWidget {
  const LittleHelpBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize the refresh toggles timer.
    ref.listen(refreshTogglesProvider, (_, __) {});
    final (appThemeMode, localePref) =
        ref.watch(userPreferencesProvider).maybeWhen(
              data: (data) => (data.appTheme, data.locale),
              orElse: () => (ThemeMode.system, Locale('en')),
            );
    return ResponsiveApp(
      builder: (context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => context.l10n.littleHelpBook,
        theme: LittleHelpBookTheme.lightTheme,
        darkTheme: LittleHelpBookTheme.darkTheme,
        themeMode: appThemeMode,
        locale: localePref,
        localizationsDelegates: LittleHelpBookL10n.localizationsDelegates,
        supportedLocales: LittleHelpBookL10n.supportedLocales,
        routerConfig: lhbRouter,
      ),
    );
  }
}
