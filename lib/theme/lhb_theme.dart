import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/theme/lhb_colors.dart';
import 'package:littlehelpbook_flutter/theme/lhb_snackbar.dart';

class LittleHelpBookTheme {
  const LittleHelpBookTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,
    snackBarTheme: snackbarTheme,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.background,
    snackBarTheme: snackbarTheme,
  );
}
