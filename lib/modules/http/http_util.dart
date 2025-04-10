import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'logs_interceptor.dart';
import 'mock_interceptor.dart';
import 'response_interceptor.dart';
import 'token_interceptor.dart';

class HttpUtil {
  // BuildContext context;
  TokenInterceptors? tokenInterceptors;

  static final HttpUtil _instance = HttpUtil._internal();

  Dio? _dio;

  static HttpUtil get instance => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpUtil._internal() {
    _dio ??= Dio(
      BaseOptions(
        connectTimeout: Duration(milliseconds: 5000),
        sendTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 5000),
      ),
    );
    _dio!.interceptors.add(LogsInterceptors());
    _dio!.interceptors.add(MockInterceptors());
  }

  Dio get client => _dio!;

  void setToken(String token) {
    print('---token---$token-------');
    tokenInterceptors = TokenInterceptors(token: token);
    _dio!.interceptors.add(tokenInterceptors!);
  }

  void deleteToken() {
    _dio!.interceptors.remove(tokenInterceptors);
  }

  void rebase(String baseIp) {
    _dio!.options.baseUrl = baseIp;
    //
    // _dio!.interceptors.add(ResponseInterceptors(context));
  }
}
