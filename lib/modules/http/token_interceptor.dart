import 'package:dio/dio.dart';

class TokenInterceptors<T> extends Interceptor {
  String token;

  TokenInterceptors({this.token = ''});

  void Function()? onTokenDisabled;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    return handler.next(response);
  }
}
