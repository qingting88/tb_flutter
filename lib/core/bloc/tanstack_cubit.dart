import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/http/http_model.dart';

abstract class TanStackState extends Equatable {
  const TanStackState();

  @override
  List<Object> get props => [];
}

final class Initialize extends TanStackState {}

final class IsLoading extends TanStackState {}

final class IsSuccess extends TanStackState {}

final class IsError extends TanStackState {}

final class Data<T> extends TanStackState {
  final T data;
  const Data(this.data);
}

final class Error extends TanStackState {
  final String message;
  const Error([this.message = '']);
}

typedef TanStackQueryFunc<T> = Future<DataT<T>> Function();

class TanStackCubit extends Cubit<TanStackState> {
  TanStackCubit() : super(Initialize());

  void query<T>(TanStackQueryFunc<T> func) async {
    emit(IsLoading());
    final resp = await func();
    if (resp.status == 'success') {
      emit(Data(resp.data));
      emit(IsSuccess());
    } else {
      emit(Error(resp.message));
      emit(IsError());
    }
  }

  void mutation<T>(TanStackQueryFunc<T> func) async {
    emit(IsLoading());
    final resp = await func();
    if (resp.status == 'success') {
      emit(Data(resp.data));
      emit(IsSuccess());
    } else {
      emit(Error(resp.message));
      emit(IsError());
    }
  }
}
