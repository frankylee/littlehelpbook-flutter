import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/common/router/lhb_router.dart';
import 'package:littlehelpbook_flutter/generated/l10n.dart';
import 'package:littlehelpbook_flutter/theme/lhb_theme.dart';

class LittleHelpBook extends StatelessWidget {
  const LittleHelpBook({super.key});

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
