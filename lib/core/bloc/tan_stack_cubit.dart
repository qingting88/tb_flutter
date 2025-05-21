import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/http/http_model.dart';

class TanStackState<T> extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final List<T>? data;
  final ErrorT? error;

  const TanStackState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.data,
    this.error,
  });

  factory TanStackState.initial() => const TanStackState();

  factory TanStackState.loading() =>
      const TanStackState(isLoading: true, isSuccess: false, isError: false);

  factory TanStackState.success(List<T> data) => TanStackState(
    isSuccess: true,
    isError: false,
    data: data,
    isLoading: false,
  );

  factory TanStackState.error(ErrorT error) => TanStackState(
    isError: true,
    isSuccess: false,
    error: error,
    isLoading: false,
  );

  TanStackState<T> copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    List<T>? data,
    ErrorT? error,
  }) {
    return TanStackState<T>(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isError, data, error];

  @override
  String toString() {
    return 'TanStackState{isLoading: $isLoading, isSuccess: $isSuccess, '
        'isError: $isError, data: $data, error: $error}';
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

      // 处理响应
      if (resp.status == 'success') {
        // 先发射数据状态
        emit(TanStackState.success(resp.data));
        // 然后发射成功状态（如果需要）
        // 注意：通常不需要单独发射IsSuccess，因为success状态已经包含isSuccess=true
      } else {
        // 发射错误状态
        emit(TanStackState.error(resp as ErrorT));
      }
    } catch (e) {
      // 捕获未预期的异常
      emit(
        TanStackState.error(
          ErrorT(
            message: e.toString(),
            code: '500',
            status: 'error',
            errors: [],
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
      print(resp);

      // 处理响应
      if (resp.status == 'success') {
        // 先发射数据状态
        emit(TanStackState.success(resp.data));
        // 然后发射成功状态（如果需要）
        // 注意：通常不需要单独发射IsSuccess，因为success状态已经包含isSuccess=true
      } else {
        // 发射错误状态
        emit(TanStackState.error(resp as ErrorT));
      }
    } catch (e) {
      print(e);
      // 捕获未预期的异常
      emit(
        TanStackState.error(
          ErrorT(
            message: e.toString(),
            code: '500',
            status: 'error',
            errors: [],
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
