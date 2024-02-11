import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class ToggleTheme extends ConsumerStatefulWidget {
  const ToggleTheme({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends ConsumerState<ToggleTheme> {
  late final List<bool> _selected;

  @override
  void initState() {
    super.initState();
    ref.read(userPreferencesProvider).maybeWhen(
      data: (prefs) {
        _selected = [
          prefs.appTheme == ThemeMode.light,
          prefs.appTheme == ThemeMode.system,
          prefs.appTheme == ThemeMode.dark,
        ];
      },
      orElse: () {
        _selected = [false, true, false];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userPreferencesProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          context.l10n.appTheme,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(width: 8.0),
        ToggleButtons(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: _selected,
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < _selected.length; i++) {
                _selected[i] = i == index;
              }
              // Update the user preference.
              switch (index) {
                case 0:
                  ref
                      .read(userPreferencesProvider.notifier)
                      .updateAppTheme(ThemeMode.light);
                case 1:
                  ref
                      .read(userPreferencesProvider.notifier)
                      .updateAppTheme(ThemeMode.system);
                case 2:
                  ref
                      .read(userPreferencesProvider.notifier)
                      .updateAppTheme(ThemeMode.dark);
              }
            });
          },
          children: [
            Text(context.l10n.themeModeLight),
            Text(context.l10n.themeModeSystem),
            Text(context.l10n.themeModeDark),
          ],
        ),
      ],
    );
  }
}
