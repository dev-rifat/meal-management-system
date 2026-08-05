import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mass_management/features/profile/domain/entities/profile.dart';

/// Renders a subset of the current user's [Profile] — name, email and
/// joining date. Takes the domain entity directly rather than a
/// feature-local model.
class ProfileWidget extends StatelessWidget {
  final Profile profile;

  const ProfileWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider(profile.profileImage),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            profile.name,
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 4),

          // Email
          Text(
            profile.email,
            style: const TextStyle(color: Colors.grey),
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
                _buildInfoRow("Full Name", profile.name),
                const Divider(),
                _buildInfoRow("Email", profile.email),
                const Divider(),
                _buildInfoRow(
                  "Joining Date",
                  DateFormat.yMMMMd().format(profile.joiningDate),
                ),
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
          Expanded(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
