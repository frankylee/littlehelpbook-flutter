import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_feature_toggles.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/widgets/bordered_container.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    if (LHBToggles.alertMessage == null || LHBToggles.alertMessage!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        const SizedBox(height: 48.0),
        BorderedContainer(
          child: Text(
            LHBToggles.alertMessage!,
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
