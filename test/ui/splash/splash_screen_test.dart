import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:littlehelpbook_flutter/app.dart';
import 'package:littlehelpbook_flutter/main.dart';
import 'package:littlehelpbook_flutter/ui/splash/splash_screen.dart';

void main() {
  testWidgets("Splash screen is the initial route", (tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    // Splash screen should no longer be in the tree for two seconds.
    await tester.pump(const Duration(seconds: 2));
    // Splash screen should be in the tree, and the main app should not.
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(ScaffoldWithNestedNavigation), findsNothing);
  });

  testWidgets("Splash screen navigates away after duration", (tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    // Splash screen should no longer be in the tree for two seconds.
    await tester.pump(const Duration(seconds: 2));
    // Allow the routing to occur.
    await tester.pump(const Duration(seconds: 1));
    // Splash screen should no longer be in the tree, but the main app should.
    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(ScaffoldWithNestedNavigation), findsOneWidget);
  });
}