import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:simple_routes/simple_routes.dart';

enum RouteParams {
  categoryName,
}

class SplashRoute extends SimpleRoute {
  const SplashRoute();

  @override
  final String path = '/splash';

  @override
  String get goPath => path;
}

class HomeRoute extends SimpleRoute {
  const HomeRoute();

  @override
  final String path = '/home';

  @override
  String get goPath => path;
}

class ServiceRoute extends SimpleRoute implements ChildRoute<HomeRoute> {
  const ServiceRoute();

  @override
  final String path = 'service';

  @override
  String get goPath => path;

  @override
  HomeRoute get parent => const HomeRoute();
}

class ServicesByCategoryRoute extends DataRoute<ServicesByCategoryData>
    implements ChildRoute<ServiceRoute> {
  const ServicesByCategoryRoute();

  @override
  String get path =>
      fromSegments(['category', RouteParams.categoryName.prefixed]);

  @override
  String get goPath => path;

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
      categoryId: state.getExtra<CategoryId>()!,
      categoryName: state.getParam(RouteParams.categoryName)!,
    );
  }

  final CategoryId categoryId;
  final String categoryName;

  @override
  CategoryId get extra => categoryId;

  @override
  Map<Enum, String> get parameters => {
        RouteParams.categoryName: categoryName,
      };
}

class FindRoute extends SimpleRoute {
  const FindRoute();

  @override
  final String path = '/find';

  @override
  String get goPath => path;
}

class FavoritesRoute extends SimpleRoute {
  const FavoritesRoute();

  @override
  final String path = '/favorites';

  @override
  String get goPath => path;
}

class SettingsRoute extends SimpleRoute {
  const SettingsRoute();

  @override
  final String path = '/settings';

  @override
  String get goPath => path;
}
