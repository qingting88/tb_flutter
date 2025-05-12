import 'package:json_annotation/json_annotation.dart';

part 'secure.g.dart';

@JsonSerializable()
class ISecureSetting {
  final bool two_factor,email_verify,phone_verify;
  ISecureSetting({required this.two_factor,required this.email_verify,required this.phone_verify});

  /// factory.
  factory ISecureSetting.fromJson(Map<String, dynamic> json) => _$ISecureSettingFromJson(json);

  Map<String, dynamic> toJson() => _$ISecureSettingToJson(this);
}


@JsonSerializable()
class IGoogleKeyQuery {
  final String secretKey;
  final String qrCode;

  IGoogleKeyQuery({required this.secretKey, required this.qrCode});

  factory IGoogleKeyQuery.fromJson(Map<String, dynamic> json) => _$IGoogleKeyQueryFromJson(json);
  Map<String, dynamic> toJson() => _$IGoogleKeyQueryToJson(this);

}

@JsonSerializable()
class I2FAQuery {
  final String verifyUuid;
  final ISecureSetting secure;

  I2FAQuery({required this.verifyUuid, required this.secure});

  factory I2FAQuery.fromJson(Map<String, dynamic> json) => _$I2FAQueryFromJson(json);
  Map<String, dynamic> toJson() => _$I2FAQueryToJson(this);
}
