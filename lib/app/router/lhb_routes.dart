import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';
import 'package:simple_routes/simple_routes.dart';

enum RouteParams {
  categoryId,
  isHardUpdate,
  serviceId,
}

class SplashRoute extends SimpleRoute {
  const SplashRoute();

  @override
  final String path = '/splash';
}

class AppUpdateRoute extends SimpleRoute {
  const AppUpdateRoute();

  @override
  final String path = '/app-update';
}

class HomeRoute extends SimpleRoute {
  const HomeRoute();

  @override
  final String path = '/home';
}

class EmergencyCrisisLinesRoute extends SimpleRoute
    implements ChildRoute<HomeRoute> {
  const EmergencyCrisisLinesRoute();

  @override
  final String path = 'crisis-lines';

  @override
  HomeRoute get parent => const HomeRoute();
}

class ProviderRoute extends SimpleRoute implements ChildRoute<HomeRoute> {
  const ProviderRoute();

  @override
  final String path = 'provider';

  @override
  HomeRoute get parent => const HomeRoute();
}

class ServiceRoute extends SimpleRoute implements ChildRoute<HomeRoute> {
  const ServiceRoute();

  @override
  final String path = 'service';

  @override
  HomeRoute get parent => const HomeRoute();
}

class ServicesByCategoryRoute extends DataRoute<ServicesByCategoryData>
    implements ChildRoute<ServiceRoute> {
  const ServicesByCategoryRoute();

  @override
  String get path => RouteParams.categoryId.prefixed;

  @override
  ServiceRoute get parent => const ServiceRoute();
}

class ServicesByCategoryData extends SimpleRouteData {
  const ServicesByCategoryData({
    required this.categoryId,
    required this.categoryName,
  });

  factory ServicesByCategoryData.fromState(GoRouterState state) {
    return ServicesByCategoryData(
      categoryId: state.getParam(RouteParams.categoryId)!,
      categoryName: state.getExtra<String>()!,
    );
  }

  final CategoryId categoryId;
  final String categoryName;

  @override
  String get extra => categoryName;

  @override
  Map<Enum, String> get parameters => {
        RouteParams.categoryId: categoryId,
      };
}

class ProvidersByServiceRoute extends DataRoute<ProvidersByServiceData>
    implements ChildRoute<ServicesByCategoryRoute> {
  const ProvidersByServiceRoute();

  @override
  String get path => RouteParams.serviceId.prefixed;

  @override
  ServicesByCategoryRoute get parent => const ServicesByCategoryRoute();
}

class ProvidersByServiceData extends ServicesByCategoryData {
  const ProvidersByServiceData({
    required super.categoryId,
    required super.categoryName,
    required this.serviceId,
    required this.serviceName,
  });

  factory ProvidersByServiceData.fromState(
    GoRouterState state,
    ServicesByCategoryData parentData,
  ) {
    return ProvidersByServiceData(
      categoryId: parentData.categoryId,
      categoryName: parentData.categoryName,
      serviceId: state.getParam(RouteParams.serviceId)!,
      serviceName: state.getExtra<String>()!,
    );
  }

  final ServiceId serviceId;
  final String serviceName;

  @override
  String get extra => serviceName;

  @override
  Map<Enum, String> get parameters => {
        ...super.parameters,
        RouteParams.serviceId: serviceId,
      };
}

class FindRoute extends SimpleRoute {
  const FindRoute();

  @override
  final String path = '/find';
}

class FavoritesRoute extends SimpleRoute {
  const FavoritesRoute();

  @override
  final String path = '/favorites';
}

class SettingsRoute extends SimpleRoute {
  const SettingsRoute();

  @override
  final String path = '/settings';
}
