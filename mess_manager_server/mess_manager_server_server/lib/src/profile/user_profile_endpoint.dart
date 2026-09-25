import 'package:serverpod_auth_idp_server/core.dart';

/// Exposes the built-in profile read/edit methods (get, changeFullName,
/// changeUserName, image upload/removal) on the client as `client.userProfile`.
/// The base class itself lives in serverpod_auth_core_server; this just
/// switches it on for this project, same as [EmailIdpEndpoint] does for auth.
class UserProfileEndpoint extends UserProfileEditBaseEndpoint {}
