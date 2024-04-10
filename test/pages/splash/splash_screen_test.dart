import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:littlehelpbook_flutter/pages/splash/splash_screen.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';

import '../../app/app.dart';
import '../../shared/app_version/app_update_provider.dart';

void main() {
  group("Splash Screen", () {
    testWidgets("Splash screen is the initial route", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestAppWrapper(
            overrides: [
              appUpdateProvider.overrideWith(
                () => AppUpdateNotifierMock(
                  returnValue: AppUpdateEnum.current,
                ),
              ),
            ],
            child: TickerMode(enabled: false, child: const SplashScreen()),
          ),
        );
        // Splash screen should be in the tree.
        await tester.pump(const Duration(seconds: 1));
        // Splash screen should be in the tree.
        expect(find.byType(SplashScreen), findsOne);
      });
    });
  });

  group("Splash Screen routes to App Update Screen for soft update", () {
    testWidgets("Splash screen navigates away after duration", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestAppWrapper(
            overrides: [
              appUpdateProvider.overrideWith(
                () => AppUpdateNotifierMock(
                  returnValue: AppUpdateEnum.softUpdate,
                ),
              ),
            ],
            child: TickerMode(enabled: false, child: const SplashScreen()),
          ),
        );
        // Splash screen should no longer be in the tree after two seconds.
        await tester.pump(const Duration(seconds: 2));
        // Allow the routing to occur.
        await tester.pumpAndSettle();
        // Splash screen should no longer be in the tree.
        expect(find.byWidget(SplashScreen()), findsNothing);
      });
    });
  });

  group("Splash Screen routes to App Update Screen for hard update", () {
    testWidgets("Splash screen navigates away after duration", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          TestAppWrapper(
            overrides: [
              appUpdateProvider.overrideWith(
                () => AppUpdateNotifierMock(
                  returnValue: AppUpdateEnum.hardUpdate,
                ),
              ),
            ],
            child: TickerMode(enabled: false, child: const SplashScreen()),
          ),
        );
        // Splash screen should no longer be in the tree for two seconds.
        await tester.pump(const Duration(seconds: 2));
        // Allow the routing to occur.
        await tester.pumpAndSettle();
        // Splash screen should no longer be in the tree.
        expect(find.byWidget(SplashScreen()), findsNothing);
      });
    });
  });
}
