import 'package:simple_routes/simple_routes.dart';

class SplashRoute extends SimpleRoute {
  const SplashRoute();

  @override
  final String path = '/splash';
}

class HomeRoute extends SimpleRoute {
  const HomeRoute();

  @override
  final String path = '/home';
}

class LoremIpsumRoute extends SimpleRoute implements ChildRoute<HomeRoute> {
  const LoremIpsumRoute();

  @override
  final String path = 'lorem';

  @override
  HomeRoute get parent => const HomeRoute();
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
