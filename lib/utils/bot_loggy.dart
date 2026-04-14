import 'package:loggy/loggy.dart';

/// Clean single-line printer for stdout / Railway logs.
///
/// Format: `12:34:56 I [Http] ← 200 raider.io/api/v1/characters/profile (143ms)`
class BotLogPrinter extends LoggyPrinter {
  const BotLogPrinter();

  @override
  void onLog(LogRecord record) {
    final t = record.time;
    final ts = '${_pad(t.hour)}:${_pad(t.minute)}:${_pad(t.second)}';
    final level = record.level.name[0].toUpperCase();
    print('$ts $level [${record.loggerName}] ${record.message}');
    if (record.error != null) print('  └─ ${record.error}');
    if (record.stackTrace != null) print('  ${record.stackTrace}');
  }

  static String _pad(int v) => v.toString().padLeft(2, '0');
}