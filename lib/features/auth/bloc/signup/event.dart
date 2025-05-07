import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// 注册邮箱
final class SignUpEmailEvent extends SignUpEvent {
  final String email;

  const SignUpEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

// 确认邮箱
final class SignUpValidEmailEvent extends SignUpEvent {
  final String email;
  final String code;

  const SignUpValidEmailEvent({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}

// 确认密码
final class SignUpPasswordEvent extends SignUpEvent {
  final String password;

  const SignUpPasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}
