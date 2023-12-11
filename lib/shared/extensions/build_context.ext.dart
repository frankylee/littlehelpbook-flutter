import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/generated/l10n.dart';

extension BuildContextExt on BuildContext {
  String? get goRouterLocation => GoRouterState.of(this).uri.toString();
  ColorScheme get colorTheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  S get l10n => S.of(this);
}
