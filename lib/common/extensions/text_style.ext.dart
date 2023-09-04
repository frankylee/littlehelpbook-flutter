import 'package:flutter/material.dart';

extension TextStyleColorExtensions on TextStyle {
  TextStyle get white {
    return copyWith(
      color: Colors.white,
    );
  }

  TextStyle get black {
    return copyWith(
      color: Colors.black87,
    );
  }

  TextStyle primary(BuildContext context) {
    return copyWith(
      color: Theme.of(context).colorScheme.primary,
    );
  }

  TextStyle secondary(BuildContext context) {
    return copyWith(
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  TextStyle error(BuildContext context) {
    return copyWith(
      color: Theme.of(context).colorScheme.error,
    );
  }
}
