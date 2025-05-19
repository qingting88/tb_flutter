import 'package:dio/dio.dart';
import 'package:tb_flutter/core/http/http_model.dart';

class UserRepository {
  final Dio _dio;
  UserRepository(this._dio);

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

  /// 安全验证发送 phone
  Future<bool> use2faVerifyMutation() async {
    final response = await _dio.post("/user/secure/verify");
    final result = DataT<Map<String, String>>.fromJson(response.data);
    if (result.status == STATUS.success.value) {
      return true;
    }
    return false;
  }
}
