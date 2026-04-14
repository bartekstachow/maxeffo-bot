import 'dart:async';

import 'package:chopper/chopper.dart';

/// Appends Battle.net required query params (namespace, locale) to every request.
class BnetQueryInterceptor implements Interceptor {
  final String namespace;

  const BnetQueryInterceptor(this.namespace);

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) {
    final uri = chain.request.uri.replace(queryParameters: {
      ...chain.request.uri.queryParameters,
      'namespace': namespace,
      'locale': 'en_US',
    });
    return chain.proceed(chain.request.copyWith(uri: uri));
  }
}