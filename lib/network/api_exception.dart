class APIException implements Exception {
  final _message;

  APIException(this._message);

  String toString() {
    return _message;
  }
}

class ErrorException extends APIException {
  ErrorException(message) : super(message);
}