// This file performs setup of the PowerSync database.
// Credit: https://github.com/journeyapps/powersync-supabase-flutter-demo/blob/main/lib/powersync.dart
import 'package:littlehelpbook_flutter/app/config/app_config.dart';
import 'package:littlehelpbook_flutter/entities/powersync/schema.dart';
import 'package:littlehelpbook_flutter/entities/powersync/supabase_connector.dart';
import 'package:littlehelpbook_flutter/entities/supabase/supabase.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';

/// Global reference to the PowerSync database.
late final PowerSyncDatabase db;

Future<String> getPowerSyncDatabasePath() async {
  final dir = await getApplicationSupportDirectory();
  return join(dir.path, AppConfig.powersyncDbPath);
}

Future<void> openPowerSyncDatabase() async {
  // Open the local database
  db = PowerSyncDatabase(
    schema: schema,
    path: await getPowerSyncDatabasePath(),
  );
  await db.initialize();
  // Connect to Supabase instance.
  await initSupabase();
  // Connect to PowerSync.
  db.connect(connector: SupabaseConnector(db));
}
