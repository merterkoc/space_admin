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
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'X-CRSF-TOKEN, X-Requested-With, Content-Type, Accept, Authorization,  Origin,',
      'Access-Control-Allow-Methods': '*',
    });
    handler.next(options);
  }
}
