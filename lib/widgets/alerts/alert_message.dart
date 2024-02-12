import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/widgets/alerts/alert_message_provider.dart';
import 'package:littlehelpbook_flutter/widgets/bordered_container.dart';

class AlertMessage extends ConsumerWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertMessage = ref.watch(alertMessageToggleProvider);
    if (alertMessage == null) return const SizedBox.shrink();
    return Column(
      children: [
        const SizedBox(height: 48.0),
        BorderedContainer(
          child: Text(
            alertMessage,
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
