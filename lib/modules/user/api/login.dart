import 'package:tb_flutter/core/utils/http.dart';

import '../model/phone.dart';
import '../model/user.dart';


class UserApi {
  // 用户邮箱注册
  static useRegisterMutation({required String email}) async {
    return await fetchByPost("/user/register", {email});
  }

  // 用户邮箱注册验证
  static useRegisterVerifyMutation({
    required String code,
    required String email,
  }) async {
    return fetchByPost("/user/register/verify", {code, email});
  }

  // 注册保存密码
  static usePasswordUpgradeMutation({required String password}) async {
    return fetchByPost("/user/password", {password});
  }

  // 用户登陆
  static useLoginMutation({
    required String username,
    required String password,
  }) async {
    return fetchByPost("/user/login", {username, password});
  }

  //用户登出
  static useLogoutMutation() async {
    return fetchByPost("/user/logout");
  }

  // 忘记密码
  static useForgotMutation({required String email}) async {
    return fetchByPost("/user/password/reset", {email});
  }

  // 忘记密码
  static useForgotVerifyMutation({
    required String code,
    required String email,
  }) async {
    return fetchByPost("/user/password/reset/verify", {code, email});
  }

  // 获取用户基本信息
  static useUserInfoQuery() async {
    return await fetchByGet<List<UserInfo>>("/user/account", {});
  }

  // 安全验证发送email
  static useSendEmailMutation({required String email}) async {
    return fetchByPost(
      "/user/secure/email/send",
      email.isNotEmpty ? {email} : {},
    );
  }

  //安全验证发送 phone
  static useSendPhoneMutation() async {
    return fetchByPost("/user/secure/phone/send", {});
  }

  // 验证2fa
  static use2faVerifyMutation({
    required SecureSetting secure_verify,
    String? verify_uuid,
  }) async {
    return fetchByPost("/user/secure/verify", {secure_verify, verify_uuid});
  }

  // 获取 ga的key
  static useGoogleKeyQuery() async {
    return fetchByGet<List<IGoogleKeyQuery>>("/user/secure/ga", {});
  }

  // 验证 ga
  static useGoogleVerifyMutation({required String code}) async {
    return fetchByPost("/user/secure/ga/verify", {code});
  }

  // 设置2fa
  static useSetting2FAMutation({required SecureSetting secure_setting}) async {
    return fetchByPost<List<I2FAQuery>>("/user/account/setting", {
      secure_setting,
    });
  }

  static useOldPasswordVerifyMutation({required String password}) async {
    return fetchByPost("/user/password/change", {password});
  }

  // 修改手机号码
  static useSavePhoneMutation({required IPhone params}) async {
    return fetchByPost("/user/phone/update", params);
  }
  // 验证手机号码
  static usePhoneVerifyMutation({required String code}) async {
    return fetchByPost("/user/phone/update/verify", { code });
  }
}
