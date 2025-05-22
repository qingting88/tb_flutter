import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/http/http_model.dart';
import 'package:tb_flutter/core/widgets/app_dialog.dart';

class TanStackState<T> extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final List<T>? data;
  final String? SuccessCode;
  final ErrorT? error;

  const TanStackState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.SuccessCode,
    this.data,
    this.error,
  });

  factory TanStackState.initial() => const TanStackState(
    isLoading: false,
    isSuccess: false,
    SuccessCode: null,
    isError: false,
    data: null,
    error: null,
  );

  factory TanStackState.loading() => const TanStackState(
    isLoading: true,
    isSuccess: false,
    isError: false,
    SuccessCode: null,
  );

  factory TanStackState.success(SuccessT<T> data) => TanStackState(
    isSuccess: true,
    isError: false,
    data: data.data,
    SuccessCode: data.code,
    error: null,
    isLoading: false,
  );

  factory TanStackState.error(ErrorT error) => TanStackState(
    isError: true,
    isSuccess: false,
    error: error,
    data: null,
    SuccessCode: null,
    isLoading: false,
  );

  TanStackState<T> copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    List<T>? data,
    String? SuccessCode,
    ErrorT? error,
  }) {
    return TanStackState<T>(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      data: data ?? this.data,
      SuccessCode: SuccessCode ?? this.SuccessCode,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isError,
    data,
    error,
    SuccessCode,
  ];

  @override
  String toString() {
    return 'TanStackState{isLoading: $isLoading, isSuccess: $isSuccess, '
        'isError: $isError, data: $data, SuccessCode: $SuccessCode, error: $error}';
  }
}

typedef TanStackQueryFunc<T> = Future<DataT<T>> Function();

class TanStackCubit<T> extends Cubit<TanStackState<T>> {
  TanStackCubit() : super(TanStackState.initial());

  Future<void> query(TanStackQueryFunc<T> func) async {
    try {
      // 发射加载状态
      emit(TanStackState.loading());

      // 执行查询函数
      final resp = await func();
      print(resp);

      // 处理响应
      if (resp is ErrorT) {
        print(
          "业务异常 status: ${resp.status} code: ${resp.code} message: ${resp.message}",
        );
        // 发射错误状态
        emit(TanStackState.error(resp));
      } else {
        // 先发射数据状态
        emit(TanStackState.success(resp as SuccessT<T>));
      }
    } on DioException catch (e) {
      // 捕获未预期的异常
      emit(
        TanStackState.error(
          ErrorT(
            code: "500",
            message: e.message as String,
            status: 'error',
            // errors: [],
          ),
        ),
      );
    }
  }

  Future<void> mutation(TanStackQueryFunc<T> func) async {
    try {
      // 发射加载状态
      emit(TanStackState.loading());

      // 执行查询函数
      final resp = await func();
      // 处理响应
      if (resp is ErrorT) {
        print(
          "业务异常 status: ${resp.status} code: ${resp.code} message: ${resp.message}",
        );
        if (resp.intercepted == true) {
          AppDialog.show(content: resp.message);
        }
        // 发射错误状态
        emit(TanStackState.error(resp));
      } else {
        // 先发射数据状态
        emit(TanStackState.success(resp as SuccessT<T>));
      }
    } on DioException catch (e) {
      // 捕获未预期的异常
      emit(
        TanStackState.error(
          ErrorT(
            code: "500",
            message: e.message as String,
            status: 'error',
            // errors: [],
          ),
        ),
      );
    }
  }

  // 可选：添加重置状态的方法
  void reset() {
    emit(TanStackState.initial());
  }
}
