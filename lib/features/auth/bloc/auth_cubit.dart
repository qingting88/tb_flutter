import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/http/token_storage.dart';
import 'package:tb_flutter/features/auth/bloc/auth_state.dart';
import 'package:tb_flutter/features/auth/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required TokenStorage tokenStorage,
  }) : _authRepository = authRepository,
       _tokenStorage = tokenStorage,
       super(AuthInitial());

  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  Future<void> updateToken(String? token) async {
    if (token == null) {
      emit(AuthUnauthenticatedState('token 不存在'));
    } else {
      await _tokenStorage.saveTokens(token);
      emit(AuthLoading());
      final user = await _authRepository.useUserInfoQuery();
      emit(
        user != null
            ? AuthenticatedState(user)
            : AuthUnauthenticatedState('user 不存在'),
      );
    }
  }

  Future<void> authCheckRequested() async {
    final token = await _tokenStorage.getAccessToken();
    print('token $token');
    return updateToken(token);
  }

  void clean() {
    _tokenStorage.clearTokens();
  }
}
