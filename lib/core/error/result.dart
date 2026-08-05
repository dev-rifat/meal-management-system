import 'package:mass_management/core/error/failure.dart';

/// Lightweight Either-style result so use cases/repositories never throw
/// across layer boundaries — callers must handle both branches explicitly.
sealed class Result<T> {
  const Result();

  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) {
    final self = this;
    if (self is ResultSuccess<T>) return onSuccess(self.data);
    return onFailure((self as ResultError<T>).failure);
  }

  bool get isSuccess => this is ResultSuccess<T>;
}

final class ResultSuccess<T> extends Result<T> {
  final T data;

  const ResultSuccess(this.data);
}

final class ResultError<T> extends Result<T> {
  final Failure failure;

  const ResultError(this.failure);
}
