import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/common/extensions/build_context.ext.dart';

/// Bottom menu bar.
// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
            label: context.l10n.home,
            icon: Icon(Icons.home_outlined),
          ),
          NavigationDestination(
            label: context.l10n.find,
            icon: Icon(Icons.search),
          ),
          NavigationDestination(
            label: context.l10n.favorites,
            icon: Icon(Icons.favorite_border),
          ),
          NavigationDestination(
            label: context.l10n.settings,
            icon: Icon(Icons.settings_outlined),
          ),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Support navigating to the initial location when tapping the item that is already active.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
