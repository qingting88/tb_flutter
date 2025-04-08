// Assuming KycStatus is an enum, you'll need to define it first
enum KycStatus {
  // Add all possible KycStatus values here, for example:
  pending,
  verified,
  rejected,
  // etc.
}

class IUserInfo {
  final String email;
  final String name;
  final String
  status; // Could also be an enum if there are more possible values
  final KycStatus kycStatus;
  final String lastLoginAt;
  final String phoneCountryCode;
  final String phoneNumber;
  final UserExtend extend;

  IUserInfo({
    required this.email,
    required this.name,
    required this.status,
    required this.kycStatus,
    required this.lastLoginAt,
    required this.phoneCountryCode,
    required this.phoneNumber,
    required this.extend,
  });

  factory IUserInfo.fromJson(Map<String, dynamic> json) {
    return IUserInfo(
      email: json['email'],
      name: json['name'],
      status: json['status'],
      kycStatus: KycStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['kyc_status'],
        orElse: () => KycStatus.pending, // default value
      ),
      lastLoginAt: json['last_login_at'],
      phoneCountryCode: json['phone_country_code'],
      phoneNumber: json['phone_number'],
      extend: UserExtend.fromJson(json['extend']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'status': status,
      'kyc_status': kycStatus.toString().split('.').last,
      'last_login_at': lastLoginAt,
      'phone_country_code': phoneCountryCode,
      'phone_number': phoneNumber,
      'extend': extend.toJson(),
    };
  }
}

class UserExtend {
  final SecureSetting secureSetting;

  UserExtend({required this.secureSetting});

  factory UserExtend.fromJson(Map<String, dynamic> json) {
    return UserExtend(
      secureSetting: SecureSetting.fromJson(json['secure_setting']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'secure_setting': secureSetting.toJson()};
  }
}

class SecureSetting {
  final bool twoFactor;
  final bool emailVerify;
  final bool phoneVerify;

  SecureSetting({
    required this.twoFactor,
    required this.emailVerify,
    required this.phoneVerify,
  });

  factory SecureSetting.fromJson(Map<String, dynamic> json) {
    return SecureSetting(
      twoFactor: json['two_factor'],
      emailVerify: json['email_verify'],
      phoneVerify: json['phone_verify'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'two_factor': twoFactor,
      'email_verify': emailVerify,
      'phone_verify': phoneVerify,
    };
  }
}

class ISecure {
  final SecureSetting secureSetting;
  final String userEmail;
  final String phoneCountryCode;
  final String phoneNumber;

  ISecure({
    required this.secureSetting,
    required this.userEmail,
    required this.phoneCountryCode,
    required this.phoneNumber,
  });

  factory ISecure.fromJson(Map<String, dynamic> json) {
    return ISecure(
      secureSetting: SecureSetting.fromJson(json['secure_setting']),
      userEmail: json['user_email'],
      phoneCountryCode: json['phone_country_code'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_setting': secureSetting.toJson(),
      'user_email': userEmail,
      'phone_country_code': phoneCountryCode,
      'phone_number': phoneNumber,
    };
  }
}

class UserInfo {
  final IUserInfo user;

  UserInfo({required this.user});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(user: IUserInfo.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson()};
  }
}

class IGoogleKeyQuery {
  final String secretKey;
  final String qrCode;

  IGoogleKeyQuery({required this.secretKey, required this.qrCode});

  factory IGoogleKeyQuery.fromJson(Map<String, dynamic> json) {
    return IGoogleKeyQuery(
      secretKey: json['secret_key'],
      qrCode: json['qr_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'secret_key': secretKey, 'qr_code': qrCode};
  }
}

class I2FAQuery {
  final String verifyUuid;
  final SecureSetting secure;

  I2FAQuery({required this.verifyUuid, required this.secure});

  factory I2FAQuery.fromJson(Map<String, dynamic> json) {
    return I2FAQuery(
      verifyUuid: json['verify_uuid'],
      secure: SecureSetting.fromJson(json['secure']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'verify_uuid': verifyUuid, 'secure': secure};
  }
}
