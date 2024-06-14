import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_extra_params.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_route_params.dart';
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
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';
import 'package:littlehelpbook_flutter/widgets/layout/scaffold_with_nested_navigation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _shellNavigatorKeyFind = GlobalKey<NavigatorState>(debugLabel: 'findTab');
final _shellNavigatorKeyFavorites =
    GlobalKey<NavigatorState>(debugLabel: 'favoritesTab');
final _shellNavigatorKeySettings =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final lhbRouter = GoRouter(
  initialLocation: LhbRoute.splash.path,
  navigatorKey: _rootNavigatorKey,
  routes: _routes,
  debugLogDiagnostics: kDebugMode,
  errorPageBuilder: (context, state) {
    Sentry.captureException(state.error);
    return const NoTransitionPage(child: PageNotFoundScreen());
  },
  redirect: (context, state) async {
    // Global redirect to App Update route if hard update is required if Splash
    // is not the current route. This ensures that the app update is enforced
    // for users who do not quit/relaunch the application.
    if (state.fullPath == LhbRoute.splash.path) return null;
    final container = ProviderScope.containerOf(context);
    final appVersion = await container.read(appUpdateProvider.future);
    if (appVersion == AppUpdateEnum.hardUpdate) {
      return LhbRoute.appUpdate.path;
    }
    return null;
  },
);

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter
final _routes = [
  GoRoute(
    name: LhbRoute.splash.name,
    path: LhbRoute.splash.path,
    pageBuilder: (context, state) => const MaterialPage(
      child: const SplashScreen(),
    ),
  ),
  GoRoute(
    name: LhbRoute.appUpdate.name,
    path: LhbRoute.appUpdate.path,
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
            name: LhbRoute.home.name,
            path: LhbRoute.home.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const HomeScreen(),
            ),
            routes: [
              GoRoute(
                name: LhbRoute.crisisLines.name,
                path: LhbRoute.crisisLines.path,
                builder: (context, state) => const EmergencyCrisisLinesScreen(),
              ),
              GoRoute(
                name: LhbRoute.provider.name,
                path: LhbRoute.provider.path,
                builder: (context, state) => const ProvidersScreen(),
              ),
              GoRoute(
                name: LhbRoute.service.name,
                path: LhbRoute.service.path,
                builder: (context, state) => const ServicesScreen(),
                routes: [
                  GoRoute(
                    name: LhbRoute.servicesByCategory.name,
                    path: LhbRoute.servicesByCategory.path,
                    builder: (context, state) {
                      final data = state.extra as Map<String, String>;
                      return ServicesByCategoryScreen(
                        categoryId: state
                            .pathParameters[LhbRouteParams.categoryId.name]!,
                        categoryName:
                            data[LhbExtraParams.categoryName.name] as String,
                      );
                    },
                    routes: [
                      GoRoute(
                        name: LhbRoute.providersByService.name,
                        path: LhbRoute.providersByService.path,
                        builder: (context, state) {
                          final data = state.extra as Map<String, String>;
                          return ProvidersByServiceScreen(
                            serviceId: state
                                .pathParameters[LhbRouteParams.serviceId.name]!,
                            serviceName:
                                data[LhbExtraParams.serviceName.name] as String,
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
            name: LhbRoute.find.name,
            path: LhbRoute.find.path,
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
            name: LhbRoute.favorites.name,
            path: LhbRoute.favorites.path,
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
            name: LhbRoute.settings.name,
            path: LhbRoute.settings.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  ),
];
