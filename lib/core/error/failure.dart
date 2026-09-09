/// What a repository maps an [Exception] to before it reaches the
/// domain/presentation layers — see `exceptions.dart` for the source side
/// of that mapping.
sealed class Failure {
  final String message;

  const Failure(this.message);
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on the server.']);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Requested data was not found.']);
}

final class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure([super.message = 'You need to sign in first.']);
}
