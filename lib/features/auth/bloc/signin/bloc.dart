import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/features/auth/bloc/auth_cubit.dart';
import 'package:tb_flutter/features/auth/bloc/signin/event.dart';
import 'package:tb_flutter/features/auth/bloc/signin/state.dart';
import 'package:tb_flutter/features/auth/repository/auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthRepository authRepository,
    required AuthCubit authCubit,
  }) : _authRepository = authRepository,
       _authCubit = authCubit,
       super(SignInInitial()) {
    on<LoginSignInEvent>(_onSignInLogin);
  }

  final AuthRepository _authRepository;
  final AuthCubit _authCubit;

  void _onSignInLogin(LoginSignInEvent event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    final token = await _authRepository.useLoginMutation(
      username: event.username,
      password: event.password,
    );
    if (token?.isNotEmpty ?? false) {
      await _authCubit.updateToken(token!);
      emit(SignInSuccess());
    } else {
      emit(SignInFailure('Login接口 token 不存在'));
    }
  }
}
