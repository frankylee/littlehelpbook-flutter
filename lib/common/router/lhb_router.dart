import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final lhbRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: _routes,
  debugLogDiagnostics: kDebugMode,
);

final _routes = [
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: '/',
    builder: (context, state) => const MyHomePage(
      title: 'Little Help Book Home Page',
    ),
  ),
];
