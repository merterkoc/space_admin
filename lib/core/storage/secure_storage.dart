import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

const String _accessToken = 'access_token';

class SecureStorage implements TokenStorage<OAuth2Token> {
  SecureStorage._();

  late FlutterSecureStorage _secureStorage;

  static final SecureStorage _instance = SecureStorage._();

  factory SecureStorage() => _instance;

  Future<void> initialize() async {
    _secureStorage = const FlutterSecureStorage();
  }

  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _accessToken);
  }

  @override
  Future<OAuth2Token?> read() async {
    final tokenString = await _secureStorage.read(key: _accessToken);

    if (tokenString == null) {
      return Future.value();
    }
    return jsonToToken(jsonDecode(tokenString) as Map<String, dynamic>);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    await _secureStorage.write(
      key: _accessToken,
      value: _tokenToJson(token),
    );
  }

  OAuth2Token? jsonToToken(Map<String, dynamic>? json) {
    if (json == null) return null;
    return OAuth2Token(
      scope: json.containsKey('access')
          ? 'access'
          : throw Exception('Invalid scope'),
      tokenType: 'Bearer',
      accessToken: json.containsKey('access') ? json['access'] as String : '',
      refreshToken:
          json.containsKey('refresh') ? json['refresh'] as String : '',
    );
  }

  String _tokenToJson(OAuth2Token token) {
    final data = <String, dynamic>{};
    if (token.scope == 'access') {
      data['access'] = token.accessToken;
    }
    data['refresh'] = token.refreshToken;
    return jsonEncode(data);
  }
}

SecureStorage secureTokenStorage = SecureStorage();
