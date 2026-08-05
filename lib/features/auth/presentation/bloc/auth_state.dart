import 'package:mass_management/features/auth/auth.dart';


abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final LoginResModel loginResModel;
  LoginSuccess({required this.loginResModel});
  @override
  List<Object?> get props => [loginResModel];
}

class LoginErrorMeg extends LoginState {
final  String? errorMeg;
  LoginErrorMeg({required this.errorMeg});
  @override
  List<Object?> get props => [errorMeg];
}
