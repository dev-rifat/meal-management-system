import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/utils/app_layout_helper.dart'
    show AppLayoutHelper;
import 'package:mass_management/core/widgets/custom_app_button.dart';
import 'package:mass_management/features/auth/domain/login_req_model.dart';
import 'package:mass_management/features/auth/presentation/blog/blog_state.dart';
import 'package:mass_management/features/auth/presentation/blog/login_event_state.dart';
import 'package:mass_management/features/auth/presentation/blog/login_state.dart';
import 'package:mass_management/features/auth/presentation/widgets/auth_from.dart'
    show AuthForm;
import '../../../../core/utils/app_spacer.dart' show customSpacerHeight;
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../widgets/common_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    ResponsiveLayout.init(context);

    return Scaffold(
      body: Padding(
        padding: AppLayoutHelper.horizontalMargin(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitleText(context),
                  customSpacerHeight(height: 30),

                  AuthForm(onSubmit: (username, password) {

                    print(username);
                    
                  }),

                  customSpacerHeight(height: 4),

                  _buildForgotPassword(),

                  customSpacerHeight(height: 30),

                  _buildLoginButton(context),

                  customSpacerHeight(height: 24),

                  guestButtonLayout(context),

                  customSpacerHeight(height: 30),

                  _buildNewUserCreate(context),

                  customSpacerHeight(height: 76),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return titleTextLayout(
      titleText: "Sign in\nto your account",
      subText: "",
      context: context,
      subTitleText: "Welcome Back You've Been Missed!",
    );
  }

  Widget _buildForgotPassword() {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text("Forgot password?", style: AppStyle.normalText),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {


      if(state is LoginLoading){
        return const CircularProgressIndicator();
      }

      return  CustomAppButton(
        text: "Login",
        widget: Text(
          "Login",
          style: AppStyle.titleText.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColor.cardColor,
            fontSize: ResponsiveLayout.scaleText(Dimensions.fontSizeMid),
          ),
        ),
        buttonRadius: Dimensions.radiusDefault,
        buttonColor: AppColor.primaryColor,
        onPressed: (){
          BlocProvider.of<LoginBloc>(context).add(
            LoginReqEvent(
              rqModel: LoginReqModel(email: "username", password: "password"),
            ),
          );
        },
      );


    },);
  }




  Widget _buildNewUserCreate(BuildContext context) {
    return createUserAccount(
      context: context,
      firstText: "New user? ",
      endText: AppString.text_sign_up,
      onAction: ()=>context.push(AppRoute.signUp),
    );
  }
}
