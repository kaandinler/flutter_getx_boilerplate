class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final String? code;
  ApiException({this.statusCode, required this.message, this.code});

  @override
  String toString() => 'ApiException(statusCode: $statusCode, code: $code, message: $message)';
}

class NoConnectionException extends ApiException {
  NoConnectionException() : super(message: 'No internet connection');
}

