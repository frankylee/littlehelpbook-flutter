import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:logging/logging.dart';

extension AsyncValueExt on AsyncValue<dynamic> {
  void showSnackbarOnError(BuildContext context, {String? message}) {
    if (!isLoading && hasError) {
      Logger('showSnackbarOnError').severe(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? context.l10n.uhOhSomethingIsWrong),
        ),
      );
    }
  }
}
