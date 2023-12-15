import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:space_admin/core/dio/http_handler/default_http_handler.dart';
import 'package:space_admin/core/storage/secure_storage.dart';
import 'package:space_admin/src/constant/http_constants.dart';

class DioClient {
  static final DioClient _instance = DioClient._();
  late Fresh<OAuth2Token> _fresh;
  late Dio _defaultHttpClient;

  factory DioClient() => _instance;

  DioClient._() {
    _defaultHttpClient = _newDioInstance(addTokenInterceptor: true);
    for (final interceptor in _defaultHttpClient.interceptors) {
      if (interceptor is Fresh) {
        _fresh = interceptor as Fresh<OAuth2Token>;
      }
    }
  }

  Dio _newDioInstance({
    bool addTokenInterceptor = false,
  }) {
    final dio = Dio()
      ..options.baseUrl = HTTPConstants.baseUrl
      ..options.connectTimeout = HTTPConstants.connectTimeout
      ..options.receiveTimeout = HTTPConstants.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      )
      ..interceptors.add(DefaultHttpHeaderInterceptor())
      ..interceptors.add(LogInterceptor(responseBody: true, request: true));

    if (addTokenInterceptor) {
      dio.interceptors.add(
        Fresh.oAuth2(
          httpClient: dio,
          tokenStorage: secureTokenStorage,
          shouldRefresh: (response) {
            return (response?.statusCode == 401 || response?.statusCode == 403);
          },
          refreshToken: (token, client) {
            return Future.value(token);
          },
        ),
      );
    }

    return dio;
  }

  /// Removes token
  Future<void> deleteToken() {
    return _fresh.revokeToken();
  }

  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  Future<void> saveToken(OAuth2Token token) async {
    await _fresh.setToken(token);
  }

  Future<Response> get({required String path, bool? loader}) async {
    try {
      Response response = await _defaultHttpClient.get(path);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }

  Future<Response> post(
    String path,
    dynamic data,
  ) async {
    try {
      Response response = await _defaultHttpClient.post(path, data: data);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }

  Future<Response> put(
      {required String path, required dynamic data, bool? loader}) async {
    try {
      Response response = await _defaultHttpClient.put(path, data: data);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }

  Future<Response> delete({required String path, bool? loader}) async {
    try {
      Response response = await _defaultHttpClient.delete(path);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }

  void unAuthenticate() {
    _fresh.clearToken();
  }
}

DioClient dioClient = DioClient();
