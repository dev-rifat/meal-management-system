import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/features/profile/widgets/profile_widgets.dart';
import 'package:mass_management/utils/app_color.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidth: 300,
        leading:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text("Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
        ),
        backgroundColor: AppColor.backgroundColor,

      ),
      body: ProfileWidget(
        user: UserModel(
          name: "John Doe",
          email: "john.doe@example.com",
          profileImage: "https://i.pravatar.cc/150?img=5",
          joiningDate: DateTime(2023, 4, 20),
        ),
      ),
    );
  }

}


