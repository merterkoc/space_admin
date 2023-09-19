import 'package:dio/dio.dart';
import 'package:space_admin/src/constant/http_constants.dart';

class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;
  final Dio _dio = Dio()
    ..options.baseUrl = HTTPConstants.baseUrl
    ..options.connectTimeout = HTTPConstants.connectTimeout
    ..options.receiveTimeout = HTTPConstants.receiveTimeout
    ..interceptors.add(LogInterceptor(responseBody: true, request: true));

  Future<Response> get(String url, {required bool loader}) async {
    try {
      await Future.delayed(const Duration(seconds: 4));
      Response response = await _dio.get(url);
      return response;
    } on DioException {
      rethrow;
    } finally {
    }
  }

  Future<Response> post(String url, dynamic data,) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response;
    } on DioException {
      rethrow;
    } finally {
    }
  }

  Future<Response> put(String url, dynamic data, {required bool loader}) async {
    try {
      Response response = await _dio.put(url, data: data);
      return response;
    } on DioException {
      rethrow;
    } finally {
    }
  }

  Future<Response> delete(String url, {required bool loader}) async {
    try {
      Response response = await _dio.delete(url);
      return response;
    } on DioException {
      rethrow;
    } finally {
    }
  }
}