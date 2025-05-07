import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

final class LoginSignInEvent extends SignInEvent {
  final String username;
  final String password;

  const LoginSignInEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
