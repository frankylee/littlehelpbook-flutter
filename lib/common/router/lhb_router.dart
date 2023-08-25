import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/app.dart';
import 'package:littlehelpbook_flutter/ui/favorite/favorites_screen.dart';
import 'package:littlehelpbook_flutter/ui/find/find_screen.dart';
import 'package:littlehelpbook_flutter/ui/home/home_screen.dart';
import 'package:littlehelpbook_flutter/ui/settings/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorKeyFind = GlobalKey<NavigatorState>(debugLabel: 'findTab');
final _shellNavigatorKeyFavorites =
    GlobalKey<NavigatorState>(debugLabel: 'favoritesTab');
final _shellNavigatorKeySettings =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final lhbRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: _routes,
  debugLogDiagnostics: kDebugMode,
);

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter
final _routes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKeyHome,
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const MyHomePage(),
            ),
            routes: [
              GoRoute(
                path: 'lorem',
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
            path: '/find',
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
            path: '/favorites',
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
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  ),
];
