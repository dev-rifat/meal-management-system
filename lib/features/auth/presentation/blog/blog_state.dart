import 'package:mass_management/features/auth/auth.dart';


class LoginBloc extends Bloc<LoginEventState, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginReqEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        LoginResModel loginResModel = await AuthRepository().login(
          event.rqModel.email ?? "",
          event.rqModel.password ?? "",
        );

        emit(LoginSuccess(loginResModel: loginResModel));
      } catch (e) {
        emit(LoginErrorMeg(errorMeg: e.toString()));
      }
    });
  }
}
