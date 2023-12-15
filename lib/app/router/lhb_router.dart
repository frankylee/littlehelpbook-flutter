import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/entities/service/widgets/services_list.dart';
import 'package:littlehelpbook_flutter/pages/favorite/favorites_screen.dart';
import 'package:littlehelpbook_flutter/pages/find/find_screen.dart';
import 'package:littlehelpbook_flutter/pages/home/home_screen.dart';
import 'package:littlehelpbook_flutter/pages/services/services_screen.dart';
import 'package:littlehelpbook_flutter/pages/settings/settings_screen.dart';
import 'package:littlehelpbook_flutter/pages/splash/splash_screen.dart';
import 'package:littlehelpbook_flutter/widgets/layout/scaffold_with_nested_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorKeyFind = GlobalKey<NavigatorState>(debugLabel: 'findTab');
final _shellNavigatorKeyFavorites =
    GlobalKey<NavigatorState>(debugLabel: 'favoritesTab');
final _shellNavigatorKeySettings =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final lhbRouter = GoRouter(
  initialLocation: const SplashRoute().fullPath(),
  navigatorKey: _rootNavigatorKey,
  routes: _routes,
  debugLogDiagnostics: kDebugMode,
);

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter
final _routes = [
  GoRoute(
    path: const SplashRoute().goPath,
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
            path: const HomeRoute().goPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: const ServiceRoute().goPath,
                builder: (context, state) => const ServicesScreen(),
                routes: [
                  GoRoute(
                    path: const ServicesByCategoryRoute().goPath,
                    builder: (context, state) {
                      final routeData = ServicesByCategoryData.fromState(state);
                      return ServicesList(
                        categoryId: routeData.categoryId,
                        categoryName: routeData.categoryName,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKeyFind,
        routes: [
          GoRoute(
            path: const FindRoute().goPath,
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
            path: const FavoritesRoute().goPath,
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
            path: const SettingsRoute().goPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  ),
];
