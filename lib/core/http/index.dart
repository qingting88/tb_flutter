import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    _dio.interceptors.add(ResponseInterceptors());
    _dio.interceptors.add(TokenInterceptor(_tokenStorage));
  }

  // 错误处理方法
  Future<void> _handleError(DioException error) async {
    String errorMessage = "发生未知错误";

    if (error.response != null) {
      // 从服务器响应中获取错误信息
      final statusCode = error.response!.statusCode;
      final errorData = error.response!.data;

      if (errorData is Map && errorData['message'] != null) {
        errorMessage = errorData['message'];
      } else {
        // 根据状态码设置默认错误消息
        switch (statusCode) {
          case 400:
            errorMessage = "请求参数错误";
            break;
          case 401:
            errorMessage = "未授权，请重新登录";
            break;
          case 403:
            errorMessage = "访问被拒绝";
            break;
          case 404:
            errorMessage = "请求的资源不存在";
            break;
          case 500:
            errorMessage = "服务器内部错误";
            break;
          default:
            errorMessage = "网络错误 [$statusCode]";
        }
      }
    } else {
      // 处理无响应错误(网络问题等)
      if (error.type == DioExceptionType.connectionTimeout) {
        errorMessage = "连接超时";
      } else if (error.type == DioExceptionType.receiveTimeout) {
        errorMessage = "接收数据超时";
      } else if (error.type == DioExceptionType.sendTimeout) {
        errorMessage = "发送请求超时";
      } else if (error.type == DioExceptionType.connectionError) {
        errorMessage = "网络连接错误";
      }
    }

    // 显示错误弹窗
    _showErrorDialog(errorMessage);
  }

  // 显示错误弹窗
  void _showErrorDialog(String message) {
    // 使用全局Key或NavigatorState来显示弹窗
    final context = navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("错误提示"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("确定"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    }
  }

  // 获取Dio实例
  Dio get dio => _dio;

  // 全局导航Key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
