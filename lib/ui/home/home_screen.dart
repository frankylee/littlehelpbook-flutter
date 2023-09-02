import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/common/extensions/build_context.ext.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
        title: Text(context.l10n.littleHelpBook),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l10n.thisIsHome,
              style: context.textTheme.headlineLarge,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => context.go('/home/lorem'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  context.colorTheme.secondaryContainer,
                ),
              ),
              child: Text(context.l10n.goToSubroute),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeSubroute extends StatelessWidget {
  const HomeSubroute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
        title: Text(context.l10n.loremIpsum),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.l10n.thisIsSubroute,
              style: context.textTheme.headlineLarge,
            ),
            Text(
              context.l10n.loremIpsumDolorSitAmet,
              style: context.textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
