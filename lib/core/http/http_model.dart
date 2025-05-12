enum STATUS {
  success("success"),
  error("error");

  final String value;

  const STATUS(this.value);
}

class SUCCESS_CODE {
  static const String SUCCESS = "100000";
  static const String USER_EMAIL_VERIFICATION_CODE_EXIST = "110001";
  static const String LOGOUT = "110002";
  static const String UPGRADE_TOKEN = "120000";
  static const String USER_ACTION_NEED_VERIFY = "120001";
}


class SERVER_ERROR_CODE {
  static const String DEFAULT = "900000";
  static const String USER_LOGIN_FAIL = "910001";
  static const String USER_REGISTER_FAIL = "910002";
  static const String TWO_FACTOR_GENERATE_KEY_FAIL = "910003";
  static const String TWO_FACTOR_ENABLE_FAIL = "910004";
  static const String CHANGE_PASSWORD_FAIL = "910005";
  static const String VERIFY_EVENT_ACTION_INVALID = "910006";
  static const String CREATE_VERIFICATION_CODE_FAILED = "910007";
  static const String TWO_FACTOR_SAVE_KEY_FAIL = "910008";
  static const String TWO_FACTOR_VERIFY_FAIL = "910009";
}

class CLIENT_ERROR_CODE {
  static const String DEFAULT = "200001";

  static const String REQUEST_LIMIT = "200003";

  static const String UNAUTHENTICATED = "210001";

  static const String SYSTEM_FORBIDDEN_REGION = "210002"; // 服务不可用

  static const String SEND_CODE_FAIL = "210003";

  static const String RESEND_CODE_FAIL = "210004";

  static const String SEND_CODE_TIME_LIMIT = "210005";

  static const String SEND_CODE_COUNT_LIMIT = "210006";

  static const String VERIFY_TWO_FACTOR_CODE_FAIL = "210007";

  static const String TWO_FACTOR_ALREADY_ENABLE = "210008";

  static const String NO_TWO_FACTOR_SECRET = "210009";

  static const String VERIFICATION_EVENT_INVALID = "210010";

  static const String SECURE_GOOGLE_AUTHENTICATOR_NEED_VERIFY = "210011";

  static const String SECURE_EMAIL_NEED_VERIFY = "210012";

  static const String SECURE_PHONE_NEED_VERIFY = "210013";

  static const String SECURE_GOOGLE_AUTHENTICATOR_VERIFY_FAIL = "210014";

  static const String SECURE_EMAIL_VERIFY_FAIL = "210015";
  static const String CODE_VERIFY_FAIL_FOR_EXPIRE = "210017";
  static const String CODE_VERIFY_FAIL_NOT_EXIST = "210018";

  static const String SECURE_PHONE_VERIFY_FAIL = "210016";
  static const String PHONE_CODE_VERIFY_FAIL_FOR_EXPIRE = "210020";
  static const String PHONE_CODE_VERIFY_FAIL_NOT_EXIST = "210021";

  static const String UNAUTHENTICATED_BY_DEVICE_CHANGE = "210019";

  static const String EMAIL_VERIFY_CODE_ERROR = "220001";

  static const String USER_EMAIL_EXIST = "230001";

  static const String USER_LOGIN_FAIL = "230002";

  static const String USER_LOGIN_CREDENTIALS_INCORRECT = "230003";
  // 用户不支持机构
  static const String USER_NOT_SUPPORT_INSTITUTION = "230004";

  static const String USER_STATUS_NO_ACCESS = "230005";

  static const String USER_EMAIL_NOT_EXIST = "230006";

  static const String USER_LOGIN_FAIL_LOCKED = "230007";

  static const String USER_EXTEND_ERROR = "230008";

  static const String AT_LEAST_OPEN_ONE_SECURE_SETTING = "230009";

  static const String ACCOUNT_SETTING_SAVE_FAILED = "230010";
  static const String GOOGLE_2FA_UNSET = "230011";
  static const String PHONE_2FA_UNSET = "230016";
}

class ErrorT {
  final String code; // CLIENT_ERROR_CODE or SERVER_ERROR_CODE
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
  final String code;
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
      code: json['code'],
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

