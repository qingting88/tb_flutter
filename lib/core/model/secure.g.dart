// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ISecureSetting _$ISecureSettingFromJson(Map<String, dynamic> json) =>
    ISecureSetting(
      two_factor: json['two_factor'] as bool,
      email_verify: json['email_verify'] as bool,
      phone_verify: json['phone_verify'] as bool,
    );

Map<String, dynamic> _$ISecureSettingToJson(ISecureSetting instance) =>
    <String, dynamic>{
      'two_factor': instance.two_factor,
      'email_verify': instance.email_verify,
      'phone_verify': instance.phone_verify,
    };

ISecure _$ISecureFromJson(Map<String, dynamic> json) => ISecure(
  user_email: json['user_email'] as String,
  phone_country_code: json['phone_country_code'] as String,
  phone_number: json['phone_number'] as String,
  secure_setting: ISecureSetting.fromJson(
    json['secure_setting'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ISecureToJson(ISecure instance) => <String, dynamic>{
  'user_email': instance.user_email,
  'phone_country_code': instance.phone_country_code,
  'phone_number': instance.phone_number,
  'secure_setting': instance.secure_setting,
};

IGoogleKeyQuery _$IGoogleKeyQueryFromJson(Map<String, dynamic> json) =>
    IGoogleKeyQuery(
      secretKey: json['secretKey'] as String,
      qrCode: json['qrCode'] as String,
    );

Map<String, dynamic> _$IGoogleKeyQueryToJson(IGoogleKeyQuery instance) =>
    <String, dynamic>{
      'secretKey': instance.secretKey,
      'qrCode': instance.qrCode,
    };

I2FAQuery _$I2FAQueryFromJson(Map<String, dynamic> json) => I2FAQuery(
  verifyUuid: json['verifyUuid'] as String,
  secure: ISecureSetting.fromJson(json['secure'] as Map<String, dynamic>),
);

Map<String, dynamic> _$I2FAQueryToJson(I2FAQuery instance) => <String, dynamic>{
  'verifyUuid': instance.verifyUuid,
  'secure': instance.secure,
};

ISecureVerify _$ISecureVerifyFromJson(Map<String, dynamic> json) =>
    ISecureVerify(
      ga_code: json['ga_code'] as String,
      email_code: json['email_code'] as String,
      phone_code: json['phone_code'] as String,
    );

Map<String, dynamic> _$ISecureVerifyToJson(ISecureVerify instance) =>
    <String, dynamic>{
      'ga_code': instance.ga_code,
      'email_code': instance.email_code,
      'phone_code': instance.phone_code,
    };

I2FaVerify _$I2FaVerifyFromJson(Map<String, dynamic> json) => I2FaVerify(
  verify_uuid: json['verify_uuid'] as String?,
  secure_verify: ISecureVerify.fromJson(
    json['secure_verify'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$I2FaVerifyToJson(I2FaVerify instance) =>
    <String, dynamic>{
      'verify_uuid': instance.verify_uuid,
      'secure_verify': instance.secure_verify,
    };
