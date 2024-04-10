import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:littlehelpbook_flutter/pages/app_update/app_update.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';

import '../../app/app.dart';
import '../../shared/app_version/app_update_provider.dart';

void main() {
  group("App Update", () {
    group('Hard app update required', () {
      testWidgets('does not show close action', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestAppWrapper(
            overrides: [
              appUpdateProvider.overrideWith(
                () => AppUpdateNotifierMock(
                  returnValue: AppUpdateEnum.hardUpdate,
                ),
              ),
            ],
            child: const AppUpdateScreen(),
          ),
        );
        await tester.pumpAndSettle();
        // Verify that the close icon is not present.
        expect(find.byIcon(Icons.close), findsNothing);
        expect(find.byType(AppUpdateScreen), findsOne);
      });
    });

    group('Soft app update available', () {
      testWidgets('shows close action', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestAppWrapper(
            overrides: [
              appUpdateProvider.overrideWith(
                () => AppUpdateNotifierMock(
                  returnValue: AppUpdateEnum.softUpdate,
                ),
              ),
            ],
            child: const AppUpdateScreen(),
          ),
        );
        await tester.pumpAndSettle();
        // Verify that the close icon is present.
        expect(find.byIcon(Icons.close), findsOne);
        expect(find.byType(AppUpdateScreen), findsOne);
      });
    });
  });
}
