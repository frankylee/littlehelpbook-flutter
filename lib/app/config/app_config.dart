import 'package:envied/envied.dart';

part 'app_config.g.dart';

@Envied()
abstract class AppConfig {
  @EnviedField(varName: 'GROWTHBOOK_API_KEY', obfuscate: true)
  static final String growthBookApiKey = _AppConfig.growthBookApiKey;

  @EnviedField(varName: 'GROWTHBOOK_HOST', obfuscate: true)
  static final String growthBookHost = _AppConfig.growthBookHost;

  @EnviedField(varName: 'MAPBOX_API_KEY', obfuscate: true)
  static final String mapboxApiKey = _AppConfig.mapboxApiKey;

  @EnviedField(varName: 'POWERSYNC_DB_PATH', obfuscate: true)
  static final String powersyncDbPath = _AppConfig.powersyncDbPath;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static final String supabaseAnonKey = _AppConfig.supabaseAnonKey;

  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static final String supabaseUrl = _AppConfig.supabaseUrl;
}
