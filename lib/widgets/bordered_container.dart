import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class BorderedContainer extends ConsumerWidget {
  const BorderedContainer({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorTheme.onSurface,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: double.maxFinite,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
        child: child,
      ),
    );
  }
}
