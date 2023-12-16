import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/widgets/button/secondary_button.dart';
import 'package:littlehelpbook_flutter/widgets/gradient_container.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      padding: EdgeInsets.fromLTRB(
        LhbStyleConstants.pagePadding,
        0,
        LhbStyleConstants.pagePadding,
        LhbStyleConstants.pageBottomPadding,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            context.l10n.pageNotFound,
            style: context.textTheme.headlineSmall?.white,
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(0),
              color: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: () => HomeRoute().go(context),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LhbStyleConstants.pagePadding,
              ),
              child: Text(
                context.l10n.uhOhSomethingIsWrong,
                style: context.textTheme.headlineMedium?.white,
              ),
            ),
            const SizedBox(height: 48.0),
            SecondaryButton(
              onPressed: () => HomeRoute().go(context),
              text: context.l10n.home,
            ),
          ],
        ),
      ),
    );
  }
}
