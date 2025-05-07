import 'package:dio/dio.dart';
import 'package:tb_flutter/core/http/token_storage.dart';

class TokenInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  TokenInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 排除不需要认证的接口
    // if (!_requiresAuthentication(options.path)) {
    //   return handler.next(options);
    // }

    // 获取 access token
    final accessToken = await _tokenStorage.getAccessToken();
    
    if (accessToken != null) {
      // 在请求头中添加 token
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    print('打印请求体');
    print(options.data); // 打印请求体

    return handler.next(options);
  }

  // bool _requiresAuthentication(String path) {
  //   // 定义不需要认证的接口路径
  //   const unauthenticatedPaths = ['/auth/login', '/auth/register', '/auth/refresh'];
  //   return !unauthenticatedPaths.any(path.startsWith);
  // }
}