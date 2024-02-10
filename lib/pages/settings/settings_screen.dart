import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_version_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
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
            ref.watch(appVersionProvider).maybeWhen(
                  data: (version) => Center(
                    child: Text(
                      context.l10n.appVersion(version),
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
          ],
        ),
      ),
    );
  }
}
