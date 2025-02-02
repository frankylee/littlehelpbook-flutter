import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/features/toggle/l10n_toggle.dart';
import 'package:littlehelpbook_flutter/features/toggle/toggle_theme.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/widgets/app_version.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: LhbStyleConstants.pagePaddingInsets,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LhbStyleConstants.maxPageContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  context.l10n.adjustYourSettings,
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 48.0),
                ToggleTheme(),
                const SizedBox(height: 24.0),
                L10nToggle(),
                const SizedBox(height: 48.0),
                AppVersion(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
