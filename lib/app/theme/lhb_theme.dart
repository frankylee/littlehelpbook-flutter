import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_colors.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_expansion_tile.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_snackbar.dart';

class LittleHelpBookTheme {
  const LittleHelpBookTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: lightColorScheme,
    expansionTileTheme: expansionTileTheme,
    scaffoldBackgroundColor: lightColorScheme.surface,
    snackBarTheme: snackbarTheme,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
    expansionTileTheme: expansionTileTheme,
    scaffoldBackgroundColor: darkColorScheme.surface,
    snackBarTheme: snackbarTheme,
  );
}
