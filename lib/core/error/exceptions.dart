/// Thrown by data sources; repository implementations catch these and map
/// them to a [Failure] before they ever reach the domain/presentation layers.
class ServerException implements Exception {
  final String message;

  const ServerException([this.message = 'Something went wrong on the server.']);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException([this.message = 'No internet connection.']);
}

class NotFoundException implements Exception {
  final String message;

  const NotFoundException([this.message = 'Requested data was not found.']);
}

class UnauthenticatedException implements Exception {
  final String message;

  const UnauthenticatedException([this.message = 'You need to sign in first.']);
}
