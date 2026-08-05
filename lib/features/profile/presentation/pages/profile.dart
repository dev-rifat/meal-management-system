import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/widgets/confirm_dialog.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/features/profile/domain/entities/profile.dart';
import 'package:mass_management/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mass_management/features/profile/presentation/cubit/profile_state.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => GetIt.instance<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          context.go(AppRoute.login);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: _buildAppBar(),
          body: switch (state) {
            ProfileLoading() => const Center(child: CircularProgressIndicator()),
            ProfileLoggedOut() => const Center(child: CircularProgressIndicator()),
            ProfileError(message: final message) => Center(child: Text(message)),
            ProfileLoaded(profile: final profile) => _buildContent(context, profile),
          },
        );
      },
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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
    );
  }

  Widget _buildContent(BuildContext context, Profile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userProfile(profile),
          const SizedBox(height: 24),
          _sectionTitle("Information"),
          _infoCard([
            _infoRow(Icons.person, "Username", profile.name),
            _infoRow(Icons.email, "Email", profile.email),
            _infoRow(Icons.phone_android, "Phone", profile.phoneNumber),
          ]),
          const SizedBox(height: 24),
          _sectionTitle("Others"),
          _infoCard([
            _infoRow(Icons.contact_phone, "Emergency Contact", profile.emergencyContact),
            _infoRow(Icons.cake, "Birthday", DateFormat('dd MMM, yyyy').format(profile.birthday)),
          ]),
          const SizedBox(height: 24),
          _logoutButton(context),
        ],
      ),
    );
  }

  // User Profile Section
  Widget _userProfile(Profile profile) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(profile.profileImage),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(profile.phoneNumber, style: const TextStyle(fontSize: 14, color: Colors.grey)),
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
  Widget _logoutButton(BuildContext context) {
    return InkWell(
      onTap: () => _handleLogoutTap(context),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.logout, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Text("Logout", style: TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogoutTap(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: "Logout",
      message: "Are you sure you want to logout?",
      confirmLabel: "Logout",
      isDestructive: true,
    );
    if (confirmed) {
      await cubit.logout();
    }
  }
}
