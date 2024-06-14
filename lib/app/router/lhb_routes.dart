enum LhbRoute {
  splash('splash'),
  appUpdate('app-update'),
  favorites('favorites'),
  find('find'),
  settings('settings'),
  // -------------
  //  HOME ROUTES
  // -------------
  home(''),
  crisisLines(
    'crisis-lines',
    parent: LhbRoute.home,
  ),
  provider(
    'provider',
    parent: LhbRoute.home,
  ),
  // -----------------------
  //  HOME / SERVICE ROUTES
  // -----------------------
  service(
    'service',
    parent: LhbRoute.home,
  ),
  servicesByCategory(
    ':categoryId',
    parent: LhbRoute.service,
  ),
  providersByService(
    ':serviceId',
    parent: LhbRoute.servicesByCategory,
  );

  const LhbRoute(
    this._path, {
    this.parent,
  });

  final String _path;
  final LhbRoute? parent;

  String get path => parent == null ? '/$_path' : _path;
}
