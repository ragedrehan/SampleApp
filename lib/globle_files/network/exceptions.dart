class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => message;
}
