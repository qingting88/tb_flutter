import 'package:dio/dio.dart';
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
    try {
      final isLoggedIn = await _authRepository.useLoginMutation(
        username: event.username,
        password: event.password,
      );
      if (isLoggedIn) {
        print("isLoggedIn");
        await _authCubit.authCheckRequested();
        emit(SignInSuccess());
      } else {
        print('Login接口 token 不存在');
        emit(SignInFailure('Login接口 token 不存在'));
      }
      // 处理数据...
    } catch (e) {
      // 错误已在拦截器处理，这里可选补充处理
      print('====>HHHHHHHHHHHHH<=====${e.toString()}');
    }
  }
}
