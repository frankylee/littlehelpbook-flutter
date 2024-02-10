import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:littlehelpbook_flutter/app/app.dart';
import 'package:littlehelpbook_flutter/pages/app_update/app_update.dart';
import 'package:littlehelpbook_flutter/pages/splash/splash_screen.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';
import 'package:littlehelpbook_flutter/widgets/layout/scaffold_with_nested_navigation.dart';

import '../../app/toggle/lhb_toggles.dart';
import '../../shared/app_version/app_update_provider.dart';

void main() {
  final appVersionHard = 'app-version-hard';
  final appVersionSoft = 'app-version-soft';

  group("Splash Screen", () {
    setUp(() {
      overrideToggles(
        overrides: {
          appVersionHard: '0.0.0',
          appVersionSoft: '0.0.0',
        },
      );
    });

    testWidgets("Splash screen is the initial route", (tester) async {
      await tester.pumpWidget(ProviderScope(child: const LittleHelpBook()));
      // Splash screen should no longer be in the tree for two seconds.
      await tester.pump(const Duration(seconds: 2));
      // Splash screen should be in the tree, and the main app should not.
      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(AppUpdateScreen), findsNothing);
      expect(find.byType(ScaffoldWithNestedNavigation), findsNothing);
    });
  });

  group("Splash Screen routes to App Update Screen for soft update", () {
    setUp(() {
      overrideToggles(
        overrides: {
          appVersionHard: '0.0.0',
          appVersionSoft: '1000.1.0',
        },
      );
    });

    testWidgets("Splash screen navigates away after duration", (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appUpdateProvider.overrideWith(
              () => SoftAppUpdateNotifierMock(),
            ),
          ],
          child: TickerMode(enabled: false, child: LittleHelpBook()),
        ),
      );
      // Splash screen should no longer be in the tree for two seconds.
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // Allow the routing to occur.
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // Splash screen should no longer be in the tree, but the app update should.
      expect(find.byType(SplashScreen), findsNothing);
      expect(find.byType(AppUpdateScreen), findsOneWidget);
      expect(find.byType(ScaffoldWithNestedNavigation), findsNothing);
    });
  });

  group("Splash Screen routes to App Update Screen for hard update", () {
    setUp(() {
      overrideToggles(
        overrides: {
          appVersionHard: '1000.0.0',
          appVersionSoft: '0.0.0',
        },
      );
    });

    testWidgets("Splash screen navigates away after duration", (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appUpdateProvider.overrideWith(
              () => HardAppUpdateNotifierMock(),
            ),
          ],
          child: TickerMode(enabled: false, child: LittleHelpBook()),
        ),
      );
      // Splash screen should no longer be in the tree for two seconds.
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // Allow the routing to occur.
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // Splash screen should no longer be in the tree, but the app update should.
      expect(find.byType(SplashScreen), findsNothing);
      expect(find.byType(AppUpdateScreen), findsOneWidget);
      expect(find.byType(ScaffoldWithNestedNavigation), findsNothing);
    });
  });
}
