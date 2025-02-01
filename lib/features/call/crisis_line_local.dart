import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CrisisLineLocal extends StatelessWidget {
  const CrisisLineLocal({super.key});

  static TextSpan asTextSpan(BuildContext context) {
    return TextSpan(
      text: context.l10n.crisisLineLocal,
      recognizer: TapGestureRecognizer()
        ..onTap =
            () => launchUrlString('tel://${context.l10n.crisisLineLocal}'),
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorTheme.tertiary,
        decoration: TextDecoration.underline,
        decorationColor: context.colorTheme.tertiary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrlString('tel://${context.l10n.crisisLineLocal}'),
      child: Text(
        context.l10n.crisisLineLocal,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorTheme.tertiary,
          decoration: TextDecoration.underline,
          decorationColor: context.colorTheme.tertiary,
        ),
      ),
    );
  }
}
