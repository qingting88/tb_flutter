// Assuming KycStatus is an enum, you'll need to define it first
import 'secure.dart';

enum KycStatus {
  // Add all possible KycStatus values here, for example:
  pending,
  verified,
  rejected,
  // etc.
}

class IUserExtend {
  final ISecureSetting secureSetting;

  IUserExtend({required this.secureSetting});

  factory IUserExtend.fromJson(Map<String, dynamic> json) {
    return IUserExtend(
      secureSetting: ISecureSetting.fromJson(json['secure_setting']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'secure_setting': secureSetting.toJson()};
  }
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
  final IUserExtend extend;

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
      extend: IUserExtend.fromJson(json['extend']),
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

class IUserInfoWrapper {
  final IUserInfo user;

  IUserInfoWrapper({required this.user});

  factory IUserInfoWrapper.fromJson(Map<String, dynamic> json) {
    return IUserInfoWrapper(user: IUserInfo.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson()};
  }
}
