import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/theme/lhb_colors.dart';

class LittleHelpBookTheme {
  const LittleHelpBookTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.background,
  );
}
