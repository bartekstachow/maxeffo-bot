import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';

/// An [http.BaseClient] that logs every outbound request and its response
/// status + elapsed time. Query parameters are omitted from logs to avoid
/// leaking auth tokens.
///
/// Inject as the default http client in any plain-HTTP client:
/// ```dart
/// MyClient([http.Client? httpClient])
///     : _httpClient = httpClient ?? LoggingHttpClient();
/// ```
class LoggingHttpClient extends http.BaseClient {
  static final _log = Loggy('Http');

  final http.Client _inner;

  LoggingHttpClient([http.Client? inner]) : _inner = inner ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final sw = Stopwatch()..start();
    _log.debug('→ ${request.method} ${_label(request.url)}');
    try {
      final response = await _inner.send(request);
      sw.stop();
      final msg =
          '← ${response.statusCode} ${_label(request.url)} (${sw.elapsedMilliseconds}ms)';
      if (response.statusCode >= 500) {
        _log.error(msg);
      } else if (response.statusCode >= 400) {
        _log.warning(msg);
      } else {
        _log.info(msg);
      }
      return response;
    } catch (e, st) {
      sw.stop();
      _log.error(
        '✗ ${request.method} ${_label(request.url)} (${sw.elapsedMilliseconds}ms)',
        e,
        st,
      );
      rethrow;
    }
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }

  static String _label(Uri url) => '${url.host}${url.path}';
}