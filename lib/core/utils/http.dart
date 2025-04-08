import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';


Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  print(filePath);
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

class CustomInterceptors extends Interceptor {
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    try {
      List<String> list = options.path.split('/').where((m)=>m.isNotEmpty).toList();
      final data = await loadJsonFromAssets(
        'assets/mock/${list[0]}/${list.sublist(1).join('.')}.json',
      );
      return handler.resolve(Response(requestOptions: options, data: data));
    } catch (e) {
      print(e);
      return handler.reject(DioException(requestOptions: options, error: "异常"));
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}

class TaskResult<T> {
  final T? data;
  final bool success;
  final String msg;
  final int count;

  TaskResult({this.data, this.success = false, this.msg = '', this.count = 0});

  @override
  String toString() {
    return 'RepResult{data: $data, status: $success, msg:$msg}';
  }

  const TaskResult.error({required this.msg})
    : success = false,
      data = null,
      count = 0;

  const TaskResult.success({this.data, this.msg = '', this.count = 0})
    : success = true;
}

class TokenInterceptors<T> extends InterceptorsWrapper {
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
}

const Duration _kReceiveTimeout = Duration(milliseconds: 5000);
const Duration _kSendTimeout = Duration(milliseconds: 5000);
const Duration _kConnectTimeout = Duration(milliseconds: 5000);

class HttpUtil {
  TokenInterceptors? tokenInterceptors;

  static final HttpUtil _instance = HttpUtil._internal();

  Dio? _dio;

  static HttpUtil get instance => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpUtil._internal() {
    _dio ??= Dio(
      BaseOptions(
        connectTimeout: _kConnectTimeout,
        sendTimeout: _kSendTimeout,
        receiveTimeout: _kReceiveTimeout,
      ),
    );
    // _dio!.interceptors.add(LogsInterceptors());
    // _dio.interceptors.add(ResponseInterceptors());
    _dio!.interceptors.add(CustomInterceptors());
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
  }
}

Future<TaskResult<T>> fetchByPost<T>(String url, [Object? data]) async {
  String errorMsg = "";

  try {
    var result = await HttpUtil.instance.client.post(url, data: data);
    print(result.data);
    if (result.data != null) {
      return TaskResult.success(data: result.data['data']);
    }
  } catch (e) {
    print(e);
    errorMsg = e.toString();
  }

  return TaskResult.error(msg: '请求错误: $errorMsg');
}

Future<TaskResult<T>> fetchByGet<T>(String url, [Object? data]) async {
  String errorMsg = "";

  try {
    var result = await HttpUtil.instance.client.get(url, data: data);
    print(result.data);
    if (result.data != null) {
      return TaskResult.success(data: result.data['data']);
    }
  } catch (e) {
    print(e);
    errorMsg = e.toString();
  }

  return TaskResult.error(msg: '请求错误: $errorMsg');
}

