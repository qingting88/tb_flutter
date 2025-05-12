import 'package:json_annotation/json_annotation.dart';
part 'auth.g.dart';

@JsonSerializable()
class IAuth {
  final String token;
  IAuth({required this.token});

  factory IAuth.fromJson(Map<String, dynamic> json) => _$IAuthFromJson(json);

  Map<String, dynamic> toJson() => _$IAuthToJson(this);
}