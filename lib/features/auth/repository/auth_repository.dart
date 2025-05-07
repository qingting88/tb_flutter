import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tb_flutter/core/http/http_model.dart';
import 'package:tb_flutter/core/models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  // 注册，第一步 注册邮箱
  Future<bool> useRegisterMutation({required String email}) async {
    final response = await _dio.post("/user/register", data: {email});
    final result = DataT<dynamic>.fromJson(response.data);
    if (result.status == STATUS.success.name) {
      return true;
    }
    return false;
  }

  // 注册，第二步 验证邮箱
  Future<String?> useRegisterVerifyMutation({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post(
      "/user/register/verify",
      data: {email, code},
    );
    final result = DataT<Map<String, String>>.fromJson(
      response.data,
      (data) => ({"token": data['token'] as String}),
    );
    if (result.status == STATUS.success.name) {
      return result.data[0]['token']!;
    }
    return null;
  }

  // 注册，第二步 确认密码
  Future<bool> usePasswordUpgradeMutation({required String password}) async {
    final response = await _dio.post("/user/password", data: {password});
    final result = DataT<dynamic>.fromJson(response.data);
    if (result.status == STATUS.success.name) {
      return true;
    }
    return false;
  }

  Future<String?> useLoginMutation({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post("/user/login", data: {username, password});
    final result = DataT<Map<String, String>>.fromJson(
      response.data,
      (data) => ({"token": data['token'] as String}),
    );
    if (result.status == STATUS.success.name) {
      return result.data[0]['token']!;
    }
    return null;
  }

  Future<IUserInfo> useUserInfoQuery() async {
    final response = await _dio.get("/user/account", data: {});
    final result = DataT<IUserInfo>.fromJson(
      response.data,
      (data) => IUserInfo.fromJson(data['user'] as Map<String, dynamic>),
    );
    return result.data[0];
  }
}
