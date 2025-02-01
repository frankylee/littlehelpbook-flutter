import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/littlehelpbook_l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'router/lhb_router.dart';

class TestAppWrapper extends StatelessWidget {
  const TestAppWrapper({
    super.key,
    required this.child,
    this.overrides = const [],
  });

  final Widget child;
  final List<Override> overrides;

  @override
  Widget build(BuildContext context) {
    final mockGoRouter = MockGoRouter();
    return ProviderScope(
      overrides: overrides,
      child: ResponsiveApp(
        builder: (context) => MaterialApp(
          localizationsDelegates: LittleHelpBookL10n.localizationsDelegates,
          supportedLocales: LittleHelpBookL10n.supportedLocales,
          theme: LittleHelpBookTheme.lightTheme,
          darkTheme: LittleHelpBookTheme.darkTheme,
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: child,
          ),
        ),
      ),
    );
  }
}
