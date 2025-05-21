import 'package:dio/dio.dart';
import 'package:tb_flutter/core/http/response_interceptor.dart';
import 'package:tb_flutter/core/http/token_interceptor.dart';
import 'package:tb_flutter/core/http/token_storage.dart';

class HttpService {
  final Dio _dio = Dio();
  final TokenStorage _tokenStorage;

  HttpService({required TokenStorage tokenStorage})
    : _tokenStorage = tokenStorage {
    // 基础配置
    // _dio.options.baseUrl = 'https://qa.treasurebox.com/v1';
    _dio.options.baseUrl = 'http://localhost:3000/api';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);

    // 添加拦截器
    _dio.interceptors.add(ResponseInterceptors(_tokenStorage));
    _dio.interceptors.add(TokenInterceptor(_tokenStorage));
  }
  // 获取Dio实例
  Dio get dio => _dio;

}
