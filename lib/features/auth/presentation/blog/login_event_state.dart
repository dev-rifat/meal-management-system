import 'package:mass_management/features/auth/auth.dart';


abstract class LoginEventState extends Equatable {}

class LoginReqEvent extends LoginEventState {
  final LoginReqModel rqModel;
  LoginReqEvent({required this.rqModel});


  @override
  List<Object?> get props => [rqModel];
}
