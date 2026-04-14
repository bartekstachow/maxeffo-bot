import 'dart:io';
import 'package:maxeffo_bot/services/api/claude/claude_client.dart';

/// Logs Claude API usage to the console and to logs/claude_usage.log.
class UsageLogger {
  static const _logDir = 'logs';
  static const _logFile = 'logs/claude_usage.log';

  Future<void> log({
    required ClaudeResponse response,
    required String triggeredBy,
    required String channelId,
  }) async {
    final now = DateTime.now();
    final timestamp = _formatTimestamp(now);
    final cost = response.estimatedCostUsd;

    final line = '[$timestamp] '
        'user=${triggeredBy.padRight(20)} '
        'channel=$channelId  '
        'in=${response.inputTokens.toString().padLeft(4)}  '
        'out=${response.outputTokens.toString().padLeft(4)}  '
        'total=${response.totalTokens.toString().padLeft(4)}  '
        'cost=\$${cost.toStringAsFixed(6)}';

    // Always print to console
    print('[Usage] $line');

    // Append to log file
    try {
      final dir = Directory(_logDir);
      if (!await dir.exists()) await dir.create(recursive: true);
      await File(_logFile).writeAsString('$line\n', mode: FileMode.append);
    } catch (e) {
      print('[Usage] Warning: could not write to log file: $e');
    }
  }

  String _formatTimestamp(DateTime dt) {
    final y = dt.year.toString();
    final mo = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final mi = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$y-$mo-$d $h:$mi:$s';
  }
}
