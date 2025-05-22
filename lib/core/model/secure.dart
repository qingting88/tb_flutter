import 'package:json_annotation/json_annotation.dart';

part 'secure.g.dart';

@JsonSerializable()
class ISecureSetting {
  final bool two_factor, email_verify, phone_verify;
  ISecureSetting({
    required this.two_factor,
    required this.email_verify,
    required this.phone_verify,
  });

  ISecureSetting copyWith({
    bool? two_factor,
    bool? email_verify,
    bool? phone_verify,
  }) {
    return ISecureSetting(
      two_factor: two_factor ?? this.two_factor,
      email_verify: email_verify ?? this.email_verify,
      phone_verify: phone_verify ?? this.phone_verify,
    );
  }

  /// factory.
  factory ISecureSetting.fromJson(Map<String, dynamic> json) =>
      _$ISecureSettingFromJson(json);

  Map<String, dynamic> toJson() => _$ISecureSettingToJson(this);
}

@JsonSerializable()
class ISecure {
  final String user_email, phone_country_code, phone_number;
  final ISecureSetting secure_setting;

  ISecure({
    required this.user_email,
    required this.phone_country_code,
    required this.phone_number,
    required this.secure_setting,
  });

  factory ISecure.fromJson(Map<String, dynamic> json) =>
      _$ISecureFromJson(json);

  Map<String, dynamic> toJson() => _$ISecureToJson(this);
}

@JsonSerializable()
class IGoogleKeyQuery {
  final String secretKey;
  final String qrCode;

  IGoogleKeyQuery({required this.secretKey, required this.qrCode});

  factory IGoogleKeyQuery.fromJson(Map<String, dynamic> json) =>
      _$IGoogleKeyQueryFromJson(json);
  Map<String, dynamic> toJson() => _$IGoogleKeyQueryToJson(this);
}

@JsonSerializable()
class I2FAQuery {
  final String verifyUuid;
  final ISecureSetting secure;

  I2FAQuery({required this.verifyUuid, required this.secure});

  factory I2FAQuery.fromJson(Map<String, dynamic> json) =>
      _$I2FAQueryFromJson(json);
  Map<String, dynamic> toJson() => _$I2FAQueryToJson(this);
}

@JsonSerializable()
class ISecureVerify {
  final String ga_code, email_code, phone_code;
  ISecureVerify({
    required this.ga_code,
    required this.email_code,
    required this.phone_code,
  });
  factory ISecureVerify.fromJson(Map<String, dynamic> json) =>
      _$ISecureVerifyFromJson(json);
  Map<String, dynamic> toJson() => _$ISecureVerifyToJson(this);
}

@JsonSerializable()
class I2FaVerify {
  final String? verify_uuid;
  final ISecureVerify secure_verify;
  I2FaVerify({this.verify_uuid, required this.secure_verify});
  factory I2FaVerify.fromJson(Map<String, dynamic> json) =>
      _$I2FaVerifyFromJson(json);
  Map<String, dynamic> toJson() => _$I2FaVerifyToJson(this);
}
