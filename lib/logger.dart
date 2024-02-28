import 'package:logging/logging.dart' hide LogRecord;
import 'package:loggy/loggy.dart';

mixin LoggerMixin {
  /// Extends class with [Logger] for reporting.
  Logger get logger => Logger(runtimeType.toString());
}

final Map<Level, LogLevel> logLevelMap = {
  Level.ALL: LogLevel.all,
  Level.INFO: LogLevel.info,
  Level.CONFIG: LogLevel.info,
  Level.SHOUT: LogLevel.error,
  Level.SEVERE: LogLevel.error,
  Level.WARNING: LogLevel.warning,
  Level.FINE: LogLevel.debug,
  Level.FINER: LogLevel.debug,
  Level.FINEST: LogLevel.debug,
  Level.OFF: LogLevel.off,
};
