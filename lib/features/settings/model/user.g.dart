// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IUserExtend _$IUserExtendFromJson(Map<String, dynamic> json) => IUserExtend(
  secure_setting: ISecureSetting.fromJson(
    json['secure_setting'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$IUserExtendToJson(IUserExtend instance) =>
    <String, dynamic>{'secure_setting': instance.secure_setting};

IUserInfo _$IUserInfoFromJson(Map<String, dynamic> json) => IUserInfo(
  email: json['email'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
  kyc_status: $enumDecode(_$KycStatusEnumMap, json['kyc_status']),
  phone_country_code: json['phone_country_code'] as String,
  phone_number: json['phone_number'] as String,
  last_login_at:
      json['last_login_at'] == null
          ? null
          : DateTime.parse(json['last_login_at'] as String),
  extend: IUserExtend.fromJson(json['extend'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IUserInfoToJson(IUserInfo instance) => <String, dynamic>{
  'email': instance.email,
  'name': instance.name,
  'status': instance.status,
  'phone_country_code': instance.phone_country_code,
  'phone_number': instance.phone_number,
  'kyc_status': _$KycStatusEnumMap[instance.kyc_status]!,
  'last_login_at': instance.last_login_at?.toIso8601String(),
  'extend': instance.extend,
};

const _$KycStatusEnumMap = {
  KycStatus.Pending: 'Pending',
  KycStatus.Verified: 'Verified',
  KycStatus.Rejected: 'Rejected',
};
