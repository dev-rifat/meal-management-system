import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart' show CustomAppBar;
import 'package:mass_management/utils/app_color.dart' show AppColor;

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        leadingWidth: 300,
        leading:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text("Member List",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
        ),
        backgroundColor: AppColor.backgroundColor,

      ),
      body: ListView.builder(
        itemCount: users.length,
        padding: EdgeInsets.zero ,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.profileImage),
              ),
              title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.username),
                  Text(user.email),
                  Text("Joined: ${DateFormat.yMMMd().format(user.joiningDate)}",
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
class UserModel {
  final String name;
  final String username;
  final String email;
  final String profileImage;
  final DateTime joiningDate;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.joiningDate,
  });
}

final List<UserModel> users = [
  UserModel(
    name: "John Doe",
    username: "@johnd",
    email: "john.doe@example.com",
    profileImage: "https://i.pravatar.cc/150?img=1",
    joiningDate: DateTime(2023, 4, 15),
  ),
  UserModel(
    name: "Jane Smith",
    username: "@janes",
    email: "jane.smith@example.com",
    profileImage: "https://i.pravatar.cc/150?img=2",
    joiningDate: DateTime(2022, 12, 5),
  ),
  // Add more users...
];
