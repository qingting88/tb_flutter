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
