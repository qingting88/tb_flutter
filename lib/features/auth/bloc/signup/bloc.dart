import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/features/auth/bloc/auth_cubit.dart';
import 'package:tb_flutter/features/auth/bloc/signup/event.dart';
import 'package:tb_flutter/features/auth/bloc/signup/state.dart';
import 'package:tb_flutter/features/auth/repository/auth_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthRepository authRepository,
    required AuthCubit authCubit,
  }) : _authRepository = authRepository,
       _authCubit = authCubit,
       super(SignUpInitial()) {
    on<SignUpEmailEvent>(_onSignUpEmail);
    on<SignUpValidEmailEvent>(_onSignUpValidEmail);
    on<SignUpPasswordEvent>(_onPasswordUpgrade);
  }

  final AuthRepository _authRepository;
  final AuthCubit _authCubit;

  void _onSignUpEmail(SignUpEmailEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    final isEmail = await _authRepository.useRegisterMutation(
      email: event.email,
    );
    if (isEmail) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure('_onSignUpEmail接口 isEmail 不存在'));
    }
  }

  void _onSignUpValidEmail(
    SignUpValidEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    final isSignUp = await _authRepository.useRegisterVerifyMutation(
      email: event.email,
      code: event.code,
    );
    if (isSignUp) {
      await _authCubit.authCheckRequested();
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure('_onSignUpValidEmail接口 token 不存在'));
    }
  }

  void _onPasswordUpgrade(
    SignUpPasswordEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    final isOk = await _authRepository.usePasswordUpgradeMutation(
      password: event.password,
    );
    if (isOk) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure('_onPasswordUpgrade 接口 isOk 不存在'));
    }
  }
}
