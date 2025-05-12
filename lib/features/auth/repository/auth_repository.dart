import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tb_flutter/core/http/http_model.dart';
import 'package:tb_flutter/features/auth/model/auth.dart';
import 'package:tb_flutter/features/settings/model/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  // 注册，第一步 注册邮箱
  Future<bool> useRegisterMutation({required String email}) async {
    final response = await _dio.post("/user/register", data: {"email": email});
    final result = DataT<IAuth>.fromJson(response.data);
    if (result.code == SUCCESS_CODE.SUCCESS) {
      return true;
    }
    return false;
  }

  // 注册，第二步 验证邮箱
  Future<bool> useRegisterVerifyMutation({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post(
      "/user/register/verify",
      data: {"email": email, "code": code},
    );
    final result = DataT<Map<String, String>>.fromJson(
      response.data,
      (data) => ({"token": data['token'] as String}),
    );
    if (result.status == STATUS.success.value) {
      return true;
    }
    return false;
  }

  // 注册，第二步 确认密码
  Future<bool> usePasswordUpgradeMutation({required String password}) async {
    final response = await _dio.post(
      "/user/password",
      data: {"password": password},
    );
    final result = DataT<dynamic>.fromJson(response.data);
    if (result.code == SUCCESS_CODE.SUCCESS) {
      return true;
    }
    return false;
  }

  Future<bool> useLoginMutation({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      "/user/login",
      data: {"username": username, "password": password},
    );
    final result = DataT<IAuth>.fromJson(
      response.data,
      (data) => IAuth.fromJson(data),
    );
    if (result.status == STATUS.success.value) {
      print("result.code = ${result.data[0].token}");
      return true;
    }
    return false;
  }

  Future<IUserInfo> useUserInfoQuery() async {
    final response = await _dio.get("/user/account", data: {});
    final result = DataT<IUserInfo>.fromJson(
      response.data,
      (data){
        print("data = $data");
        return IUserInfo.fromJson(data['user']);
      },
    );
    return result.data[0];
  }
}
