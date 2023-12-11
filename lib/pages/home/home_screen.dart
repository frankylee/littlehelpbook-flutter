import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/pages/home/widgets/white_bird_logo.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.littleHelpBook),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            WhiteBirdLogo(),
            const SizedBox(height: 60.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                context.l10n.findServiceProvidersInLaneCounty,
                style: context.textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 60.0),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.medical_services_outlined),
              ),
              title: Text(
                context.l10n.services,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              trailing: Icon(Icons.chevron_right_rounded),
              enableFeedback: true,
              onTap: () async => Future.delayed(
                const Duration(milliseconds: 120),
                () async => ServiceRoute().go(context),
              ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.business_rounded),
              ),
              title: Text(
                context.l10n.providers,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              trailing: Icon(Icons.chevron_right_rounded),
              enableFeedback: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
