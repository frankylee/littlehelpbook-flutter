import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/littlehelpbook_l10n.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExt on BuildContext {
  ColorScheme get colorTheme => Theme.of(this).colorScheme;

  String? get goRouterLocation => GoRouterState.of(this).uri.toString();

  LittleHelpBookL10n get l10n => LittleHelpBookL10n.of(this)!;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
