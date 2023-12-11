import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/shared/assets/assets.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class WhiteBirdLogo extends StatelessWidget {
  const WhiteBirdLogo({
    super.key,
    this.width = 160.0,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    // TODO: This includes a short-term solution for displaying the logo in Light mode, but we
    // will most likely need to create a black logo to update the asset based on device theme.
    return SizedBox(
      width: width,
      child: Image.asset(
        Assets.whiteBirdClinicLogo,
        color: context.colorTheme.brightness == Brightness.light
            ? Colors.black
            : null,
        colorBlendMode: context.colorTheme.brightness == Brightness.light
            ? BlendMode.srcIn
            : null,
      ),
    );
  }
}
