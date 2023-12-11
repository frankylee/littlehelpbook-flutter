import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_colors.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_snackbar.dart';

class LittleHelpBookTheme {
  const LittleHelpBookTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,
    snackBarTheme: snackbarTheme,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.background,
    snackBarTheme: snackbarTheme,
  );
}
