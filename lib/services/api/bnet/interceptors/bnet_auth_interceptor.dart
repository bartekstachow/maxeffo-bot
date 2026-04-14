import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

/// Fetches and caches a Battle.net OAuth2 client-credentials token,
/// then injects it as a Bearer header on every request.
class BnetAuthInterceptor implements Interceptor {
  final _TokenCache _cache;

  BnetAuthInterceptor({
    required String clientId,
    required String clientSecret,
  }) : _cache = _TokenCache(clientId: clientId, clientSecret: clientSecret);

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final token = await _cache.getToken();
    final request =
        applyHeader(chain.request, 'Authorization', 'Bearer $token');
    return chain.proceed(request);
  }
}

/// Holds and refreshes the OAuth token. Kept separate so [BnetAuthInterceptor]
/// itself can satisfy Chopper's @immutable constraint.
class _TokenCache {
  final String _clientId;
  final String _clientSecret;

  String? _accessToken;
  DateTime? _tokenExpiry;

  _TokenCache({required String clientId, required String clientSecret})
      : _clientId = clientId,
        _clientSecret = clientSecret;

  Future<String> getToken() async {
    if (_accessToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!)) {
      return _accessToken!;
    }

    final credentials = base64Encode(utf8.encode('$_clientId:$_clientSecret'));
    final response = await http.post(
      Uri.parse('https://oauth.battle.net/token'),
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials',
    );

    if (response.statusCode != 200) {
      throw Exception(
          '[BnetAuth] OAuth failed (${response.statusCode}): ${response.body}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    _accessToken = data['access_token'] as String;
    _tokenExpiry = DateTime.now()
        .add(Duration(seconds: (data['expires_in'] as int) - 60));

    return _accessToken!;
  }
}