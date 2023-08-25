import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/common/extensions/build_context.ext.dart';

class FindScreen extends StatelessWidget {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
        title: Text(context.l10n.findServiceProviders),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l10n.findServiceProvidersByCategoryLocation,
              style: context.textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
