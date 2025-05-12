import 'package:json_annotation/json_annotation.dart';
import 'package:tb_flutter/features/settings/model/secure.dart';

part 'user.g.dart';

enum KycStatus {
  // Add all possible KycStatus values here, for example:
  @JsonValue('Pending')
  Pending,
  @JsonValue('Verified')
  Verified,
  @JsonValue('Rejected')
  Rejected,
  // etc.
}

@JsonSerializable()
class IUserExtend {
  final ISecureSetting secure_setting;

  IUserExtend({required this.secure_setting});

  /// factory.
  factory IUserExtend.fromJson(Map<String, dynamic> json) =>
      _$IUserExtendFromJson(json);

  Map<String, dynamic> toJson() => _$IUserExtendToJson(this);
}

@JsonSerializable()
class IUserInfo {
  /// The generated code assumes these values exist in JSON.
  final String email, name, status, phone_country_code, phone_number;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final KycStatus kyc_status;
  final DateTime? last_login_at;
  final IUserExtend extend;

  IUserInfo({
    required this.email,
    required this.name,
    required this.status,
    required this.kyc_status,
    required this.phone_country_code,
    required this.phone_number,
    this.last_login_at,
    required this.extend,
  });

  /// factory.
  factory IUserInfo.fromJson(Map<String, dynamic> json) =>
      _$IUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$IUserInfoToJson(this);
}
