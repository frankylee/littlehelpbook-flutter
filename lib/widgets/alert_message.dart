import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/widgets/bordered_container.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    if (LhbToggles.alertMessage == null || LhbToggles.alertMessage!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        const SizedBox(height: 48.0),
        BorderedContainer(
          child: Text(
            LhbToggles.alertMessage!,
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
