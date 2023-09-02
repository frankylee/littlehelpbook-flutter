import 'package:flutter/foundation.dart';
import 'package:littlehelpbook_flutter/common/config/app_config.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Global reference to the Supabase client.
final supabaseClient = Supabase.instance.client;

Future<void> initSupabase() async {
  final logger = Logger('Supabase');
  try {
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
      debug: kDebugMode,
    );
  } catch (e) {
    logger.severe('Supabase could not be initialized', e);
  }
}
