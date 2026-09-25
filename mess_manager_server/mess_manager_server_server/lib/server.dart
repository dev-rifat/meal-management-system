import 'dart:async';
import 'dart:io';

import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // Serve all files in the web/static relative directory under /.
  // These are used by the default web page.
  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // Start the server.
  await pod.start();
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // Always logged too, so local dev works even before Gmail is configured
  // (see EMAIL_SETUP.md) — check the server console if no email arrives.
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
  unawaited(_sendVerificationEmail(
    session,
    to: email,
    subject: 'Your Mess Manager verification code',
    body: 'Your verification code is: $verificationCode\n\n'
        'Enter this in the app to finish creating your account.',
  ));
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
  unawaited(_sendVerificationEmail(
    session,
    to: email,
    subject: 'Reset your Mess Manager password',
    body: 'Your password reset code is: $verificationCode\n\n'
        'Enter this in the app to reset your password.',
  ));
}

/// Sends [body] to [to] via Gmail SMTP, using the `gmailAddress`/
/// `gmailAppPassword` entries in `config/passwords.yaml` (see
/// EMAIL_SETUP.md for how to get an app password). Those are placeholders
/// by default — until a real Gmail account is configured, this does
/// nothing and callers fall back to the console log above, so local dev
/// keeps working without any email setup.
Future<void> _sendVerificationEmail(
  Session session, {
  required String to,
  required String subject,
  required String body,
}) async {
  final address = session.passwords['gmailAddress'];
  final appPassword = session.passwords['gmailAppPassword'];
  if (address == null ||
      appPassword == null ||
      address.startsWith('<') ||
      appPassword.startsWith('<')) {
    return;
  }

  final message = mailer.Message()
    ..from = mailer.Address(address, 'Mess Manager')
    ..recipients.add(to)
    ..subject = subject
    ..text = body;

  try {
    await mailer.send(message, gmail(address, appPassword));
  } on mailer.MailerException catch (e) {
    session.log(
      '[EmailIdp] Failed to email $to: $e',
      level: LogLevel.warning,
    );
  }
}
