import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/common/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/ui/favorite/favorites_screen.dart';
import 'package:littlehelpbook_flutter/ui/find/find_screen.dart';
import 'package:littlehelpbook_flutter/ui/home/home_screen.dart';
import 'package:littlehelpbook_flutter/ui/navigation/scaffold_with_nested_navigation.dart';
import 'package:littlehelpbook_flutter/ui/settings/settings_screen.dart';
import 'package:littlehelpbook_flutter/ui/splash/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorKeyFind = GlobalKey<NavigatorState>(debugLabel: 'findTab');
final _shellNavigatorKeyFavorites =
    GlobalKey<NavigatorState>(debugLabel: 'favoritesTab');
final _shellNavigatorKeySettings =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final lhbRouter = GoRouter(
  initialLocation: const SplashRoute().path,
  navigatorKey: _rootNavigatorKey,
  routes: _routes,
  debugLogDiagnostics: kDebugMode,
);

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter
final _routes = [
  GoRoute(
    path: const SplashRoute().path,
    pageBuilder: (context, state) => const MaterialPage(
      child: const SplashScreen(),
    ),
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKeyHome,
        routes: [
          GoRoute(
            path: const HomeRoute().path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const MyHomePage(),
            ),
            routes: [
              GoRoute(
                path: const LoremIpsumRoute().path,
                builder: (context, state) => const HomeSubroute(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKeyFind,
        routes: [
          GoRoute(
            path: const FindRoute().path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const FindScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKeyFavorites,
        routes: [
          GoRoute(
            path: const FavoritesRoute().path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const FavoritesScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKeySettings,
        routes: [
          GoRoute(
            path: const SettingsRoute().path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  ),
];
