import 'package:dio/dio.dart';
import 'package:tb_flutter/core/http/http_model.dart';
import 'package:tb_flutter/core/model/auth.dart';
import 'package:tb_flutter/core/model/secure.dart';
import 'package:tb_flutter/core/model/user.dart';

class UserRepository {
  final Dio _dio;
  UserRepository(this._dio);

  Future<DataT<Map<String, String>>> useRegisterMutation({
    required String email,
  }) async {
    final response = await _dio.post("/user/register", data: {"email": email});
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  // 注册，第二步 验证邮箱
  Future<DataT<IAuth>> useRegisterVerifyMutation({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post(
      "/user/register/verify",
      data: {"email": email, "code": code},
    );
    return DataT<IAuth>.fromJson(response.data, (data) => IAuth.fromJson(data));
  }

  /// 保存密码 （包含注册）
  Future<DataT<Map<String, String>>> usePasswordUpgradeMutation({
    required String password,
  }) async {
    final response = await _dio.post(
      "/user/password",
      data: {"password": password},
    );
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 登陆
  Future<DataT<IAuth>> useLoginMutation({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      "/user/login",
      data: {"username": username, "password": password},
    );
    return DataT<IAuth>.fromJson(response.data, (data) => IAuth.fromJson(data));
  }

  /// 忘记密码 发送邮箱验证码
  Future<DataT<Map<String, String>>> useForgotMutation({
    required String email,
  }) async {
    final response = await _dio.post(
      "/user/password/reset",
      data: {"email": email},
    );
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 忘记密码 确认邮箱
  Future<DataT<Map<String, dynamic>>> useForgotVerifyMutation({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post(
      "/user/password/reset/verify",
      data: {"email": email, "code": code},
    );
    return DataT<Map<String, dynamic>>.fromJson(response.data);
  }

  /// 用户信息查询
  Future<DataT<IUserInfo>> useUserInfoQuery() async {
    final response = await _dio.get("/user/account", data: {});
    return DataT<IUserInfo>.fromJson(response.data, (data) {
      return IUserInfo.fromJson(data['user']);
    });
  }

  /// 安全验证发送email
  Future<DataT<Map<String, String>>> useSendEmailMutation({
    required String email,
  }) async {
    final response = await _dio.post(
      "/user/secure/email/send",
      data: {"email": email},
    );
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 安全验证发送 phone
  Future<DataT<Map<String, String>>> useSendPhoneMutation() async {
    final response = await _dio.post("/user/secure/phone/send");
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 验证2fa 
  Future<DataT<Map<String, String>>> use2faVerifyMutation(I2FaVerify param) async {
    final response = await _dio.post("/user/secure/verify",data: param.toJson());
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 确认旧密码
  Future<DataT<Map<String, String>>> useOldPasswordVerifyMutation({
    required String password,
  }) async {
    final response = await _dio.post(
      "/user/password/change",
      data: {"password": password},
    );
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 修改手机号码
  Future<DataT<Map<String, String>>> useSavePhoneMutation({
    required String password,
  }) async {
    final response = await _dio.post(
      "/user/phone/update",
      data: {"password": password},
    );
    return DataT<Map<String, String>>.fromJson(response.data);
  }

  /// 设置2fa
  Future<DataT<Map<String, String>>> useSetting2FAMutation({
    required ISecureSetting secureSetting,
  }) async {
    final response = await _dio.post(
      "/user/account/setting",
      data: {"secure_setting": secureSetting.toJson()},
    );
    return DataT<Map<String, String>>.fromJson(response.data);
  }
}
