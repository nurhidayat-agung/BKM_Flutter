class Failure implements Exception {
  final _message;

  Failure(this._message);

  String toString() {
    return _message;
  }
}

class ErrorException extends Failure {
  ErrorException(message) : super(message);
}