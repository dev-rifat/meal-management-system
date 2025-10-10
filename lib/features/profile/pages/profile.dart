import 'package:flutter/material.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/utils/app_style.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserModel(
      name: "John Doe",
      email: "john.doe@example.com",
      profileImage: "https://i.pravatar.cc/150?img=5",
      phoneNumber: "+880123456789",
      joiningDate: DateTime(2023, 4, 20),
      birthday: DateTime(1995, 7, 15),
      emergencyContact: "+880987654321",
    );

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userProfile(user),
            const SizedBox(height: 24),
            _sectionTitle("Information"),
            _infoCard([
              _infoRow(Icons.person, "Username", user.name),
              _infoRow(Icons.email, "Email", user.email),
              _infoRow(Icons.phone_android, "Phone", user.phoneNumber),
            ]),
            const SizedBox(height: 24),
            _sectionTitle("Others"),
            _infoCard([
              _infoRow(Icons.contact_phone, "Emergency Contact", user.emergencyContact),
              _infoRow(Icons.cake, "Birthday", DateFormat('dd MMM, yyyy').format(user.birthday)),
            ]),
            const SizedBox(height: 24),
            _logoutButton(),
          ],
        ),
      ),
    );
  }

  // AppBar
  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 300,
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
    );
  }

  // User Profile Section
  Widget _userProfile(UserModel user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.profileImage),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(user.phoneNumber,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  // Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: AppStyle.titleText),
    );
  }

  // Info Card
  Widget _infoCard(List<Widget> children) {
    return Card(
      elevation: 0,
      color: AppColor.disableColor.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: _addDividers(children),
        ),
      ),
    );
  }

  // Info Row
  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Text("$title:", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        ],
      ),
    );
  }

  // Add Dividers Between Rows
  List<Widget> _addDividers(List<Widget> children) {
    final List<Widget> widgets = [];
    for (var i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      if (i != children.length - 1) widgets.add(const Divider());
    }
    return widgets;
  }

  // Logout Button
  Widget _logoutButton() {
    return InkWell(
      onTap: () {
        // Handle logout logic here
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Icon(Icons.logout, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Text("Logout",
                style: TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// User Model
class UserModel {
  final String name;
  final String email;
  final String profileImage;
  final String phoneNumber;
  final DateTime joiningDate;
  final DateTime birthday;
  final String emergencyContact;

  UserModel({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.phoneNumber,
    required this.joiningDate,
    required this.birthday,
    required this.emergencyContact,
  });
}
