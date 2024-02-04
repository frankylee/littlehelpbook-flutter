import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/widgets/gradient_container.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.child,
    this.onPressed,
    this.text,
  }) : assert(child != null || text != null, 'child or text must be provided');

  final Widget? child;
  final void Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(24.0),
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          maximumSize: Size.fromWidth(
            getValueForScreenType(
              context: context,
              mobile: 100.sw,
              tablet: 60.sw,
            ),
          ),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        child: Center(
          child: child ??
              Text(
                text!,
                style: context.textTheme.bodyLarge?.white
                    .copyWith(fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }
}
