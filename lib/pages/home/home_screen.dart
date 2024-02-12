import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/widgets/alerts/alert_message.dart';
import 'package:littlehelpbook_flutter/widgets/white_bird_logo.dart';

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
        padding: LhbStyleConstants.pagePaddingInsets,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 640.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                WhiteBirdLogo(),
                const AlertMessage(),
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
                    child: Icon(Icons.health_and_safety_rounded),
                  ),
                  title: Text(
                    context.l10n.emergencyCrisisLines,
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.chevron_right_rounded),
                  enableFeedback: true,
                  onTap: () async => Future.delayed(
                    const Duration(milliseconds: 120),
                    () async => EmergencyCrisisLinesRoute().go(context),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.medical_services_rounded),
                  ),
                  title: Text(
                    context.l10n.services,
                    style: context.textTheme.bodyLarge,
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
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.chevron_right_rounded),
                  enableFeedback: true,
                  onTap: () async => Future.delayed(
                    const Duration(milliseconds: 120),
                    () async => ProviderRoute().go(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
