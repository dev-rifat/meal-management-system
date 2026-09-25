/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:mess_manager_server_client/src/protocol/mess/models/member_financial_summary.dart'
    as _i5;
import 'package:mess_manager_server_client/src/protocol/mess/models/mess_financial_summary.dart'
    as _i6;
import 'package:mess_manager_server_client/src/protocol/mess/models/monthly_summary_result.dart'
    as _i7;
import 'package:mess_manager_server_client/src/protocol/mess/models/transaction_record.dart'
    as _i8;
import 'package:mess_manager_server_client/src/protocol/mess/models/expense.dart'
    as _i9;
import 'package:mess_manager_server_client/src/protocol/mess/models/expense_type.dart'
    as _i10;
import 'package:mess_manager_server_client/src/protocol/mess/models/bill_type.dart'
    as _i11;
import 'package:mess_manager_server_client/src/protocol/mess/models/meal_entry.dart'
    as _i12;
import 'package:mess_manager_server_client/src/protocol/mess/models/meal_status.dart'
    as _i13;
import 'package:mess_manager_server_client/src/protocol/mess/models/mess.dart'
    as _i14;
import 'package:mess_manager_server_client/src/protocol/mess/models/mess_member.dart'
    as _i15;
import 'package:mess_manager_server_client/src/protocol/mess/models/mess_member_profile.dart'
    as _i16;
import 'package:mess_manager_server_client/src/protocol/mess/models/mess_member_payment_status.dart'
    as _i17;
import 'package:mess_manager_server_client/src/protocol/mess/models/payment.dart'
    as _i18;
import 'dart:typed_data' as _i19;
import 'protocol.dart' as _i20;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Computed aggregates for the dashboard/wallet/monthly-summary screens —
/// derived from [Payment] (deposits), [Expense] and [MealEntry] rows
/// rather than stored anywhere directly. "Meal rate" throughout means
/// total market (food) expense divided by total *approved* meal count —
/// shared expenses (bills) don't factor into it.
/// {@category Endpoint}
class EndpointDashboard extends _i2.EndpointRef {
  EndpointDashboard(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// The caller's own all-time deposits vs. recorded expenses (both
  /// market and shared expenses they were recorded as the spender of).
  _i3.Future<_i5.MemberFinancialSummary> getMemberSummary() =>
      caller.callServerEndpoint<_i5.MemberFinancialSummary>(
        'dashboard',
        'getMemberSummary',
        {},
      );

  /// The whole mess's deposits/food-expense/meal-rate for [month]
  /// (`null` means the current month).
  _i3.Future<_i6.MessFinancialSummary> getMessSummary({DateTime? month}) =>
      caller.callServerEndpoint<_i6.MessFinancialSummary>(
        'dashboard',
        'getMessSummary',
        {'month': month},
      );

  /// [month]'s mess-wide totals plus the per-member breakdown — each
  /// member's total (approved) meal count, the cost that implies at this
  /// month's meal rate, and what they've paid in over the same month.
  _i3.Future<_i7.MonthlySummaryResult> getMonthlySummary({
    required DateTime month,
  }) => caller.callServerEndpoint<_i7.MonthlySummaryResult>(
    'dashboard',
    'getMonthlySummary',
    {'month': month},
  );

  /// The caller's own transaction history: their deposits and the
  /// expenses they were recorded as the spender of, newest first.
  _i3.Future<List<_i8.TransactionRecord>> getTransactions() =>
      caller.callServerEndpoint<List<_i8.TransactionRecord>>(
        'dashboard',
        'getTransactions',
        {},
      );
}

/// Market and shared expenses — any mess member can read; only a manager
/// can record one.
/// {@category Endpoint}
class EndpointExpense extends _i2.EndpointRef {
  EndpointExpense(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'expense';

  /// A market expense, attributed to [spentByMemberId].
  _i3.Future<_i9.Expense> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required int spentByMemberId,
  }) => caller.callServerEndpoint<_i9.Expense>(
    'expense',
    'addExpense',
    {
      'title': title,
      'amount': amount,
      'date': date,
      'details': details,
      'spentByMemberId': spentByMemberId,
    },
  );

  /// A shared expense under [billType] — finds-or-creates that bill type
  /// by name within the caller's mess.
  _i3.Future<_i9.Expense> addSharedExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String details,
    required int spentByMemberId,
    required String billType,
  }) => caller.callServerEndpoint<_i9.Expense>(
    'expense',
    'addSharedExpense',
    {
      'title': title,
      'amount': amount,
      'date': date,
      'details': details,
      'spentByMemberId': spentByMemberId,
      'billType': billType,
    },
  );

  /// Every expense in the caller's mess, optionally filtered by [type] and
  /// a case-insensitive [query] against the title.
  _i3.Future<List<_i9.Expense>> getExpenses({
    required String query,
    _i10.ExpenseType? type,
  }) => caller.callServerEndpoint<List<_i9.Expense>>(
    'expense',
    'getExpenses',
    {
      'query': query,
      'type': type,
    },
  );

  /// Every bill type name defined in the caller's mess.
  /// Every bill type defined in the caller's mess (id+name — the id is
  /// needed to resolve `Expense.billTypeId` back to a name for display).
  _i3.Future<List<_i11.BillType>> getBillTypes() =>
      caller.callServerEndpoint<List<_i11.BillType>>(
        'expense',
        'getBillTypes',
        {},
      );
}

/// Meal entries — a member (or their manager) submits counts per day/meal
/// type; a manager approves/rejects them. See [MealEntry]'s doc comment
/// for why this replaces two disconnected mock concepts.
/// {@category Endpoint}
class EndpointMeal extends _i2.EndpointRef {
  EndpointMeal(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'meal';

  /// Submits (or overwrites) [memberId]'s meal counts for [date] —
  /// re-submitting resets status to pending, since the counts changed and
  /// need re-approval. A non-manager can only submit for themself.
  _i3.Future<List<_i12.MealEntry>> submit({
    required int memberId,
    required DateTime date,
    required Map<String, double> mealCounts,
  }) => caller.callServerEndpoint<List<_i12.MealEntry>>(
    'meal',
    'submit',
    {
      'memberId': memberId,
      'date': date,
      'mealCounts': mealCounts,
    },
  );

  /// Every meal entry in the caller's mess for [month] (matched by
  /// year+month, day ignored), optionally filtered by [status].
  _i3.Future<List<_i12.MealEntry>> getMealsForMonth({
    required DateTime month,
    _i13.MealStatus? status,
  }) => caller.callServerEndpoint<List<_i12.MealEntry>>(
    'meal',
    'getMealsForMonth',
    {
      'month': month,
      'status': status,
    },
  );

  /// Manager-only.
  _i3.Future<_i12.MealEntry> updateStatus({
    required int mealEntryId,
    required _i13.MealStatus status,
  }) => caller.callServerEndpoint<_i12.MealEntry>(
    'meal',
    'updateStatus',
    {
      'mealEntryId': mealEntryId,
      'status': status,
    },
  );
}

/// Create/join a mess — the step that runs right after the caller registers
/// through Serverpod's built-in email-auth endpoints. Requires login; each
/// AuthUser can complete this at most once ([MessMember.authUserId] is
/// unique), matching the app's one-mess-per-account flow.
/// {@category Endpoint}
class EndpointMess extends _i2.EndpointRef {
  EndpointMess(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mess';

  /// Creates a new mess and attaches the caller to it as manager. Returns
  /// the [Mess] (not the [MessMember] join row) — the invite code is what
  /// the caller actually needs back, to show the user.
  _i3.Future<_i14.Mess> create({
    required String name,
    required String phone,
  }) => caller.callServerEndpoint<_i14.Mess>(
    'mess',
    'create',
    {
      'name': name,
      'phone': phone,
    },
  );

  /// Joins an existing mess by its invite code, attaching the caller as a
  /// member. Returns the joined [Mess].
  _i3.Future<_i14.Mess> join({
    required String inviteCode,
    required String phone,
  }) => caller.callServerEndpoint<_i14.Mess>(
    'mess',
    'join',
    {
      'inviteCode': inviteCode,
      'phone': phone,
    },
  );

  /// The current caller's membership row, or null if they haven't
  /// created/joined a mess yet.
  _i3.Future<_i15.MessMember?> currentMembership() =>
      caller.callServerEndpoint<_i15.MessMember?>(
        'mess',
        'currentMembership',
        {},
      );

  /// Every member of the caller's own mess, combining [MessMember] with
  /// their Serverpod profile (name/email) — see [MessMemberProfile]'s doc
  /// comment for why this isn't just a plain table row.
  _i3.Future<List<_i16.MessMemberProfile>> members() =>
      caller.callServerEndpoint<List<_i16.MessMemberProfile>>(
        'mess',
        'members',
        {},
      );

  /// Updates a member's payment status — manager-only, and only within the
  /// manager's own mess.
  _i3.Future<void> updateMemberPayment({
    required int memberId,
    required _i17.MessMemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
  }) => caller.callServerEndpoint<void>(
    'mess',
    'updateMemberPayment',
    {
      'memberId': memberId,
      'paymentStatus': paymentStatus,
      'paymentDate': paymentDate,
    },
  );

  /// Removes a member from the caller's mess — manager-only. A manager
  /// can't remove themself this way (there'd be no manager left); that's
  /// intentionally unsupported for now.
  _i3.Future<void> removeMember({required int memberId}) =>
      caller.callServerEndpoint<void>(
        'mess',
        'removeMember',
        {'memberId': memberId},
      );
}

/// A member's deposits into the mess — the credit side of their balance.
/// Any member can read; only a manager can record one (e.g. after
/// collecting cash).
/// {@category Endpoint}
class EndpointPayment extends _i2.EndpointRef {
  EndpointPayment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'payment';

  _i3.Future<_i18.Payment> addPayment({
    required int memberId,
    required double amount,
    required DateTime date,
  }) => caller.callServerEndpoint<_i18.Payment>(
    'payment',
    'addPayment',
    {
      'memberId': memberId,
      'amount': amount,
      'date': date,
    },
  );

  /// Every payment recorded in the caller's mess, newest first.
  _i3.Future<List<_i18.Payment>> getPayments() =>
      caller.callServerEndpoint<List<_i18.Payment>>(
        'payment',
        'getPayments',
        {},
      );
}

/// Exposes the built-in profile read/edit methods (get, changeFullName,
/// changeUserName, image upload/removal) on the client as `client.userProfile`.
/// The base class itself lives in serverpod_auth_core_server; this just
/// switches it on for this project, same as [EmailIdpEndpoint] does for auth.
/// {@category Endpoint}
class EndpointUserProfile extends _i4.EndpointUserProfileEditBase {
  EndpointUserProfile(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfile';

  /// Removes the user's uploaded image, setting it to null.
  ///
  /// The client should handle displaying a placeholder for users without images.
  @override
  _i3.Future<_i4.UserProfileModel> removeUserImage() =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfile',
        'removeUserImage',
        {},
      );

  /// Sets a new user image for the signed in user.
  @override
  _i3.Future<_i4.UserProfileModel> setUserImage(_i19.ByteData image) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfile',
        'setUserImage',
        {'image': image},
      );

  /// Changes the name of a user.
  @override
  _i3.Future<_i4.UserProfileModel> changeUserName(String? userName) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfile',
        'changeUserName',
        {'userName': userName},
      );

  /// Changes the full name of a user.
  @override
  _i3.Future<_i4.UserProfileModel> changeFullName(String? fullName) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfile',
        'changeFullName',
        {'fullName': fullName},
      );

  /// Returns the user profile of the current user.
  @override
  _i3.Future<_i4.UserProfileModel> get() =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfile',
        'get',
        {},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i20.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    dashboard = EndpointDashboard(this);
    expense = EndpointExpense(this);
    meal = EndpointMeal(this);
    mess = EndpointMess(this);
    payment = EndpointPayment(this);
    userProfile = EndpointUserProfile(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointDashboard dashboard;

  late final EndpointExpense expense;

  late final EndpointMeal meal;

  late final EndpointMess mess;

  late final EndpointPayment payment;

  late final EndpointUserProfile userProfile;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'dashboard': dashboard,
    'expense': expense,
    'meal': meal,
    'mess': mess,
    'payment': payment,
    'userProfile': userProfile,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
