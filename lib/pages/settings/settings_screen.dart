import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/features/toggle_theme/toggle_theme.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/widgets/app_version.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l10n.adjustYourSettings,
              style: context.textTheme.headlineLarge?.primary(context),
            ),
            const SizedBox(height: 48.0),
            ToggleTheme(),
            const SizedBox(height: 48.0),
            AppVersion(),
          ],
        ),
      ),
    );
  }
}
