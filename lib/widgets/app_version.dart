import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_version_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class AppVersion extends ConsumerWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(appVersionProvider).maybeWhen(
          data: (version) => Center(
            child: Text(
              context.l10n.appVersion(version),
              style: context.textTheme.bodySmall,
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
  }
}
