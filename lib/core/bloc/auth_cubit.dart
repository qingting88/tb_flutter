import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/http/token_storage.dart';
import 'package:tb_flutter/features/auth/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:tb_flutter/core/model/user.dart';

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

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required TokenStorage tokenStorage,
  }) : _authRepository = authRepository,
       _tokenStorage = tokenStorage,
       super(AuthInitial());

  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;


  Future<void> authCheckRequested() async {
    final token = await _tokenStorage.getAccessToken();
    print('token: $token');
    if (token != null) {
      emit(AuthLoading());
      final user = await _authRepository.useUserInfoQuery();
      emit(
        user != null
            ? AuthenticatedState(user)
            : AuthUnauthenticatedState('user 不存在'),
      );
    } else {
      emit(AuthUnauthenticatedState('token 不存在'));
    }
  }

  void clean() {
    _tokenStorage.clearTokens();
  }
}
