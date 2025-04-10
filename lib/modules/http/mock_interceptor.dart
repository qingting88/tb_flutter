import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

class MockInterceptors<T> extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      List<String> list =
          options.path.split('/').where((m) => m.isNotEmpty).toList();
      final data = await loadJsonFromAssets(
        'assets/mock/${list[0]}/${list.sublist(1).join('.')}.json',
      );
      return handler.resolve(Response(requestOptions: options, data: data));
    } catch (e) {
      return handler.reject(DioException(requestOptions: options, error: "异常"));
    }
  }
}
