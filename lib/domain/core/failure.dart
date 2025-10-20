/// Domain-level Failure hierarchy for consistent error handling.
abstract class Failure implements Exception {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  String toString() => code != null ? '[$code] $message' : message;
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message, super.code});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}

