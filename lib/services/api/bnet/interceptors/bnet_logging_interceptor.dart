import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:loggy/loggy.dart';

/// Chopper interceptor that logs every Battle.net API request and response.
class BnetLoggingInterceptor implements Interceptor {
  static final _log = Loggy('Bnet');

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final request = chain.request;
    final sw = Stopwatch()..start();
    _log.debug('→ ${request.method} ${request.url.path}');
    try {
      final response = await chain.proceed(request);
      sw.stop();
      final msg =
          '← ${response.statusCode} ${request.url.path} (${sw.elapsedMilliseconds}ms)';
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
        '✗ ${request.method} ${request.url.path} (${sw.elapsedMilliseconds}ms)',
        e,
        st,
      );
      rethrow;
    }
  }
}