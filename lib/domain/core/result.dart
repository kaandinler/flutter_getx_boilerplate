import 'package:getx_boilerplate/domain/core/failure.dart';

/// Lightweight Result/Either style type for returning success or failure.
class Result<T> {
  final T? data;
  final Failure? failure;

  const Result._({this.data, this.failure});

  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(Failure failure) => Result._(failure: failure);

  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;

  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) {
    final f = failure;
    if (f != null) return onFailure(f);
    return onSuccess(data as T);
  }

  T? getOrNull() => data;

  T getOrElse(T Function() orElse) => data ?? orElse();

  Result<R> map<R>(R Function(T data) mapper) {
    if (isFailure) return Result.failure(failure!);
    return Result.success(mapper(data as T));
  }
}

