import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class ProfileWidget extends StatelessWidget {
  final UserModel user;

  const ProfileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.profileImage),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            user.name,
            style:TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 4),

          // Email
          Text(
            user.email,
            style:TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Basic Info Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Full Name", user.name),
                const Divider(),
                _buildInfoRow("Email", user.email),
                const Divider(),
                _buildInfoRow("Joining Date", DateFormat.yMMMMd().format(user.joiningDate)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          const SizedBox(width: 12),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}


class UserModel {
  final String name;
  final String email;
  final String profileImage;
  final DateTime joiningDate;

  UserModel({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.joiningDate,
  });
}
