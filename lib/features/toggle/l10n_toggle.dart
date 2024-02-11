import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class L10nToggle extends ConsumerStatefulWidget {
  const L10nToggle({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _L10nToggleState();
}

class _L10nToggleState extends ConsumerState<L10nToggle> {
  final _english = Locale('en');
  final _spanish = Locale('es');

  late final List<bool> _selected;

  @override
  void initState() {
    super.initState();
    ref.read(userPreferencesProvider).maybeWhen(
      data: (prefs) {
        _selected = [
          prefs.locale == _english,
          prefs.locale == _spanish,
        ];
      },
      orElse: () {
        _selected = [true, false];
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
          context.l10n.language,
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
                      .updateLocale(_english);
                case 1:
                  ref
                      .read(userPreferencesProvider.notifier)
                      .updateLocale(_spanish);
              }
            });
          },
          children: [
            Text(context.l10n.english),
            Text(context.l10n.spanish),
          ],
        ),
      ],
    );
  }
}
