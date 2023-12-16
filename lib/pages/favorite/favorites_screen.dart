import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/widgets/button/primary_button.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
        title: Text(context.l10n.favorites),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l10n.checkOutYourFavorites,
              style: context.textTheme.headlineLarge?.secondary(context),
            ),
            const SizedBox(height: 48.0),
            PrimaryButton(
              onPressed: () => context.go('404'),
              text: '404 Page Not Found',
            ),
          ],
        ),
      ),
    );
  }
}
