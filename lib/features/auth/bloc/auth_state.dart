import 'package:equatable/equatable.dart';
import 'package:tb_flutter/core/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthenticatedState extends AuthState {
  final IUserInfo user;
  const AuthenticatedState(this.user);
}

class AuthUnauthenticatedState extends AuthState {
  final String message;
  const AuthUnauthenticatedState(this.message);
  @override
  List<Object> get props => [message];
}
