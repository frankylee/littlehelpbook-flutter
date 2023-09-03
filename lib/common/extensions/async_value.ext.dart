import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExt on AsyncValue<dynamic> {
  void showSnackbarOnError(BuildContext context) {
    if (!isLoading && hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }
}
