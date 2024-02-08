import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/pages/app_update/app_update.dart';
import 'package:littlehelpbook_flutter/pages/emergency_crisis_lines/emergency_crisis_lines_screen.dart';
import 'package:littlehelpbook_flutter/pages/error/page_not_found.dart';
import 'package:littlehelpbook_flutter/pages/favorite/favorites_screen.dart';
import 'package:littlehelpbook_flutter/pages/find/find_screen.dart';
import 'package:littlehelpbook_flutter/pages/home/home_screen.dart';
import 'package:littlehelpbook_flutter/pages/providers/providers_screen.dart';
import 'package:littlehelpbook_flutter/pages/services/providers_by_service_screen.dart';
import 'package:littlehelpbook_flutter/pages/services/services_by_category_screen.dart';
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
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: PageNotFoundScreen(),
  ),
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
  GoRoute(
    path: const AppUpdateRoute().goPath,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: const AppUpdateScreen(),
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
                path: const EmergencyCrisisLinesRoute().goPath,
                builder: (context, state) => const EmergencyCrisisLinesScreen(),
              ),
              GoRoute(
                path: const ProviderRoute().goPath,
                builder: (context, state) => const ProvidersScreen(),
              ),
              GoRoute(
                path: const ServiceRoute().goPath,
                builder: (context, state) => const ServicesScreen(),
                routes: [
                  GoRoute(
                    path: const ServicesByCategoryRoute().goPath,
                    builder: (context, state) {
                      final routeData = ServicesByCategoryData.fromState(state);
                      return ServicesByCategoryScreen(
                        categoryId: routeData.categoryId,
                        categoryName: routeData.categoryName,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: const ProvidersByServiceRoute().goPath,
                        builder: (context, state) {
                          final parentData =
                              ServicesByCategoryData.fromState(state);
                          final routeData = ProvidersByServiceData.fromState(
                            state,
                            parentData,
                          );
                          return ProvidersByServiceScreen(
                            serviceId: routeData.serviceId,
                            serviceName: routeData.serviceName,
                          );
                        },
                      ),
                    ],
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
