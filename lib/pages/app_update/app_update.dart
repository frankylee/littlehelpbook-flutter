import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_version_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/widgets/button/secondary_button.dart';
import 'package:littlehelpbook_flutter/widgets/gradient_container.dart';

class AppUpdateScreen extends ConsumerWidget {
  const AppUpdateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The Splash Screen loads the provider, so we know we can require the value.
    final appVersion = ref.watch(appVersionProvider).requireValue;
    return GradientContainer(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      padding: EdgeInsets.zero,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            if (appVersion != AppVersionEnum.hardUpdate)
              IconButton(
                padding: const EdgeInsets.all(0),
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () => HomeRoute().go(context),
              ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: LhbStyleConstants.pagePaddingInsets,
          child: Column(
            children: [
              Text(
                context.l10n.welcomeBack,
                style: context.textTheme.headlineLarge?.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                context.l10n.timeForAnUpdate,
                style: context.textTheme.headlineMedium?.white,
              ),
              const SizedBox(height: 32.0),
              Text(
                context.l10n.updateYourAppVersion,
                style: context.textTheme.bodyLarge?.white,
              ),
              const SizedBox(height: 48.0),
              Column(
                children: [
                  SecondaryButton(
                    text: context.l10n.updateNow,
                    onPressed: () {/** TODO: Launch App Store */},
                  ),
                  if (appVersion != AppVersionEnum.hardUpdate)
                    const SizedBox(width: 16.0),
                  if (appVersion != AppVersionEnum.hardUpdate)
                    Center(
                      child: TextButton(
                        child: Text(
                          context.l10n.updateLater,
                          style: context.textTheme.bodyMedium?.white,
                        ),
                        onPressed: () => HomeRoute().go(context),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
