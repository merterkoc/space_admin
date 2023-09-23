import 'package:dio/dio.dart';
import 'package:space_admin/core/dio/http_handler/default_http_handler.dart';
import 'package:space_admin/src/constant/http_constants.dart';

class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;
  final Dio _dio = Dio()
    ..options.baseUrl = HTTPConstants.baseUrl
    ..options.connectTimeout = HTTPConstants.connectTimeout
    ..options.receiveTimeout = HTTPConstants.receiveTimeout
    ..options.responseType = ResponseType.json
    ..interceptors.add(DefaultHttpHeaderInterceptor())
    ..interceptors.add(LogInterceptor(responseBody: true, request: true));

  Future<Response> get({required String path, bool? loader}) async {
    try {
      Response response = await _dio.get(path);
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
      Response response = await _dio.post(path, data: data);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }

  Future<Response> put({required String path, required dynamic data, bool? loader}) async {
    try {
      Response response = await _dio.put(path, data: data);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }

  Future<Response> delete({required String path, bool? loader}) async {
    try {
      Response response = await _dio.delete(path);
      return response;
    } on DioException {
      rethrow;
    } finally {}
  }
}
