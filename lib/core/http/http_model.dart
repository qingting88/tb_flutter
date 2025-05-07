enum STATUS {
  success("success"),
  error("error");

  final String value;

  const STATUS(this.value);
}

enum SUCCESS_CODE {
  success("100000"),
  userEmailVerificationCodeExist("110001"),
  logout("110002"),
  upgradeToken("120000"),
  userActionNeedVerify("120001");

  final String value;

  const SUCCESS_CODE(this.value);
}

enum SERVER_ERROR_CODE {
  defaultError("900000"),
  userLoginFail("910001"),
  userRegisterFail("910002"),
  twoFactorGenerateKeyFail("910003"),
  twoFactorEnableFail("910004"),
  changePasswordFail("910005"),
  verifyEventActionInvalid("910006"),
  createVerificationCodeFailed("910007"),
  twoFactorSaveKeyFail("910008"),
  twoFactorVerifyFail("910009");

  final String value;

  const SERVER_ERROR_CODE(this.value);
}

enum CLIENT_ERROR_CODE {
  defaultError("200001"),
  requestLimit("200003"),
  unauthenticated("210001"),
  systemForbiddenRegion("210002"), // 服务不可用
  sendCodeFail("210003"),
  resendCodeFail("210004"),
  sendCodeTimeLimit("210005"),
  sendCodeCountLimit("210006"),
  verifyTwoFactorCodeFail("210007"),
  twoFactorAlreadyEnable("210008"),
  noTwoFactorSecret("210009"),
  verificationEventInvalid("210010"),
  secureGoogleAuthenticatorNeedVerify("210011"),
  secureEmailNeedVerify("210012"),
  securePhoneNeedVerify("210013"),
  secureGoogleAuthenticatorVerifyFail("210014"),
  secureEmailVerifyFail("210015"),
  codeVerifyFailForExpire("210017"),
  codeVerifyFailNotExist("210018"),
  securePhoneVerifyFail("210016"),
  phoneCodeVerifyFailForExpire("210020"),
  phoneCodeVerifyFailNotExist("210021"),
  unauthenticatedByDeviceChange("210019"),
  emailVerifyCodeError("220001"),
  userEmailExist("230001"),
  userLoginFail("230002"),
  userLoginCredentialsIncorrect("230003"),
  userNotSupportInstitution("230004"), // 用户不支持机构
  userStatusNoAccess("230005"),
  userEmailNotExist("230006"),
  userLoginFailLocked("230007"),
  userExtendError("230008"),
  atLeastOpenOneSecureSetting("230009"),
  accountSettingSaveFailed("230010"),
  google2faUnset("230011"),
  phone2faUnset("230016");

  final String value;

  const CLIENT_ERROR_CODE(this.value);
}

class ErrorT {
  final dynamic code; // CLIENT_ERROR_CODE or SERVER_ERROR_CODE
  final String message;
  final String status; // 'success' or 'error'
  final List<Map<String, dynamic>> errors;

  ErrorT({
    required this.code,
    required this.message,
    required this.status,
    required this.errors,
  });

  factory ErrorT.fromJson(Map<String, dynamic> json) {
    return ErrorT(
      code: json['code'],
      message: json['message'],
      status: json['status'],
      errors: List<Map<String, dynamic>>.from(json['errors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'status': status,
      'errors': errors,
    };
  }
}

class DataT<T> {
  final List<T> data;
  final SUCCESS_CODE code;
  final String message;
  final String status; // 'success' or 'error'

  DataT({
    required this.data,
    required this.code,
    required this.message,
    required this.status,
  });

  factory DataT.fromJson(
    Map<String, dynamic> json, [
    T Function(dynamic)? fromJsonT,
  ]) {
    return DataT<T>(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => fromJsonT != null ? fromJsonT(e) : e as T)
              .toList(),
      code: SUCCESS_CODE.values.firstWhere((e) => e.value == json['code']),
      message: json['message'],
      status: json['status'],
    );
  }

  // Map<String, dynamic> toJson(dynamic Function(T) toJsonT) {
  //   return {
  //     'data': toJsonT(data),
  //     'code': code.value,
  //     'message': message,
  //     'status': status,
  //   };
  // }
}
