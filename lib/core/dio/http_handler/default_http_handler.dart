import 'package:dio/dio.dart';

/// [DefaultHttpHeaderInterceptor] is used to send default http headers during
/// network request.
class DefaultHttpHeaderInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers.addAll({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Methods': 'GET,PUT,PATCH,POST,DELETE',
    });
    handler.next(options);
  }
}
