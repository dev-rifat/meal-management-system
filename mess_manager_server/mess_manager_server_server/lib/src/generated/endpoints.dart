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

import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../mess/dashboard_endpoint.dart' as _i4;
import '../mess/expense_endpoint.dart' as _i5;
import '../mess/meal_endpoint.dart' as _i6;
import '../mess/mess_endpoint.dart' as _i7;
import '../mess/payment_endpoint.dart' as _i8;
import '../profile/user_profile_endpoint.dart' as _i9;
import 'package:mess_manager_server_server/src/generated/mess/models/expense_type.dart'
    as _i10;
import 'package:mess_manager_server_server/src/generated/mess/models/meal_status.dart'
    as _i11;
import 'package:mess_manager_server_server/src/generated/mess/models/mess_member_payment_status.dart'
    as _i12;
import 'dart:typed_data' as _i13;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i14;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i15;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'dashboard': _i4.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'expense': _i5.ExpenseEndpoint()
        ..initialize(
          server,
          'expense',
          null,
        ),
      'meal': _i6.MealEndpoint()
        ..initialize(
          server,
          'meal',
          null,
        ),
      'mess': _i7.MessEndpoint()
        ..initialize(
          server,
          'mess',
          null,
        ),
      'payment': _i8.PaymentEndpoint()
        ..initialize(
          server,
          'payment',
          null,
        ),
      'userProfile': _i9.UserProfileEndpoint()
        ..initialize(
          server,
          'userProfile',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getMemberSummary': _i1.MethodConnector(
          name: 'getMemberSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .getMemberSummary(session),
        ),
        'getMessSummary': _i1.MethodConnector(
          name: 'getMessSummary',
          params: {
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .getMessSummary(
                    session,
                    month: params['month'],
                  ),
        ),
        'getMonthlySummary': _i1.MethodConnector(
          name: 'getMonthlySummary',
          params: {
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .getMonthlySummary(
                    session,
                    month: params['month'],
                  ),
        ),
        'getTransactions': _i1.MethodConnector(
          name: 'getTransactions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .getTransactions(session),
        ),
      },
    );
    connectors['expense'] = _i1.EndpointConnector(
      name: 'expense',
      endpoint: endpoints['expense']!,
      methodConnectors: {
        'addExpense': _i1.MethodConnector(
          name: 'addExpense',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'details': _i1.ParameterDescription(
              name: 'details',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'spentByMemberId': _i1.ParameterDescription(
              name: 'spentByMemberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['expense'] as _i5.ExpenseEndpoint).addExpense(
                    session,
                    title: params['title'],
                    amount: params['amount'],
                    date: params['date'],
                    details: params['details'],
                    spentByMemberId: params['spentByMemberId'],
                  ),
        ),
        'addSharedExpense': _i1.MethodConnector(
          name: 'addSharedExpense',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'details': _i1.ParameterDescription(
              name: 'details',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'spentByMemberId': _i1.ParameterDescription(
              name: 'spentByMemberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'billType': _i1.ParameterDescription(
              name: 'billType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['expense'] as _i5.ExpenseEndpoint)
                  .addSharedExpense(
                    session,
                    title: params['title'],
                    amount: params['amount'],
                    date: params['date'],
                    details: params['details'],
                    spentByMemberId: params['spentByMemberId'],
                    billType: params['billType'],
                  ),
        ),
        'getExpenses': _i1.MethodConnector(
          name: 'getExpenses',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i10.ExpenseType?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['expense'] as _i5.ExpenseEndpoint).getExpenses(
                    session,
                    query: params['query'],
                    type: params['type'],
                  ),
        ),
        'getBillTypes': _i1.MethodConnector(
          name: 'getBillTypes',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['expense'] as _i5.ExpenseEndpoint)
                  .getBillTypes(session),
        ),
      },
    );
    connectors['meal'] = _i1.EndpointConnector(
      name: 'meal',
      endpoint: endpoints['meal']!,
      methodConnectors: {
        'submit': _i1.MethodConnector(
          name: 'submit',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'mealCounts': _i1.ParameterDescription(
              name: 'mealCounts',
              type: _i1.getType<Map<String, double>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _i6.MealEndpoint).submit(
                session,
                memberId: params['memberId'],
                date: params['date'],
                mealCounts: params['mealCounts'],
              ),
        ),
        'getMealsForMonth': _i1.MethodConnector(
          name: 'getMealsForMonth',
          params: {
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i11.MealStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['meal'] as _i6.MealEndpoint).getMealsForMonth(
                    session,
                    month: params['month'],
                    status: params['status'],
                  ),
        ),
        'updateStatus': _i1.MethodConnector(
          name: 'updateStatus',
          params: {
            'mealEntryId': _i1.ParameterDescription(
              name: 'mealEntryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i11.MealStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _i6.MealEndpoint).updateStatus(
                session,
                mealEntryId: params['mealEntryId'],
                status: params['status'],
              ),
        ),
      },
    );
    connectors['mess'] = _i1.EndpointConnector(
      name: 'mess',
      endpoint: endpoints['mess']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mess'] as _i7.MessEndpoint).create(
                session,
                name: params['name'],
                phone: params['phone'],
              ),
        ),
        'join': _i1.MethodConnector(
          name: 'join',
          params: {
            'inviteCode': _i1.ParameterDescription(
              name: 'inviteCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mess'] as _i7.MessEndpoint).join(
                session,
                inviteCode: params['inviteCode'],
                phone: params['phone'],
              ),
        ),
        'currentMembership': _i1.MethodConnector(
          name: 'currentMembership',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mess'] as _i7.MessEndpoint)
                  .currentMembership(session),
        ),
        'members': _i1.MethodConnector(
          name: 'members',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mess'] as _i7.MessEndpoint).members(session),
        ),
        'updateMemberPayment': _i1.MethodConnector(
          name: 'updateMemberPayment',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'paymentStatus': _i1.ParameterDescription(
              name: 'paymentStatus',
              type: _i1.getType<_i12.MessMemberPaymentStatus>(),
              nullable: false,
            ),
            'paymentDate': _i1.ParameterDescription(
              name: 'paymentDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mess'] as _i7.MessEndpoint).updateMemberPayment(
                    session,
                    memberId: params['memberId'],
                    paymentStatus: params['paymentStatus'],
                    paymentDate: params['paymentDate'],
                  ),
        ),
        'removeMember': _i1.MethodConnector(
          name: 'removeMember',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mess'] as _i7.MessEndpoint).removeMember(
                session,
                memberId: params['memberId'],
              ),
        ),
      },
    );
    connectors['payment'] = _i1.EndpointConnector(
      name: 'payment',
      endpoint: endpoints['payment']!,
      methodConnectors: {
        'addPayment': _i1.MethodConnector(
          name: 'addPayment',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['payment'] as _i8.PaymentEndpoint).addPayment(
                    session,
                    memberId: params['memberId'],
                    amount: params['amount'],
                    date: params['date'],
                  ),
        ),
        'getPayments': _i1.MethodConnector(
          name: 'getPayments',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['payment'] as _i8.PaymentEndpoint)
                  .getPayments(session),
        ),
      },
    );
    connectors['userProfile'] = _i1.EndpointConnector(
      name: 'userProfile',
      endpoint: endpoints['userProfile']!,
      methodConnectors: {
        'removeUserImage': _i1.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i9.UserProfileEndpoint)
                  .removeUserImage(session),
        ),
        'setUserImage': _i1.MethodConnector(
          name: 'setUserImage',
          params: {
            'image': _i1.ParameterDescription(
              name: 'image',
              type: _i1.getType<_i13.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i9.UserProfileEndpoint)
                  .setUserImage(
                    session,
                    params['image'],
                  ),
        ),
        'changeUserName': _i1.MethodConnector(
          name: 'changeUserName',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i9.UserProfileEndpoint)
                  .changeUserName(
                    session,
                    params['userName'],
                  ),
        ),
        'changeFullName': _i1.MethodConnector(
          name: 'changeFullName',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i9.UserProfileEndpoint)
                  .changeFullName(
                    session,
                    params['fullName'],
                  ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i9.UserProfileEndpoint)
                  .get(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i14.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i15.Endpoints()
      ..initializeEndpoints(server);
  }
}
