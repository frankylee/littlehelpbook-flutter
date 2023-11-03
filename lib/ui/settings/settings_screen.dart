import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/common/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/common/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/data/powersync/widgets/query_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
        title: Text(context.l10n.settings),
      ),
      body: QueryWidget(defaultQuery: 'SELECT * from categories LIMIT 10'),
      // body: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 24.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         context.l10n.adjustYourSettings,
      //         style: context.textTheme.headlineLarge?.primary(context),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
