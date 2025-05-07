import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class SignUpSuccess extends SignUpState {}
