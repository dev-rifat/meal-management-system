import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/widgets/app_input_field.dart'
    show CustomInputField;
import 'package:mass_management/core/widgets/confirm_dialog.dart'
    show showConfirmDialog;
import 'package:mass_management/core/widgets/custom_app_bar.dart'
    show CustomAppBar;
import 'package:mass_management/core/widgets/custom_onloading.dart'
    show LoadingHelper;
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/presentation/cubit/members_cubit.dart';
import 'package:mass_management/features/members/presentation/cubit/members_state.dart';
import 'package:mass_management/core/theme/app_color.dart' show AppColor;

/// Expects a [MembersCubit] to already be provided above it in the widget
/// tree (e.g. via `BlocProvider(create: (_) => sl<MembersCubit>())`) — this
/// page does not reach into a service locator itself.
class MemberListPage extends StatefulWidget {
  final UserRole viewerRole;

  const MemberListPage({super.key, required this.viewerRole});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _handleDelete(Member member) async {
    final confirmed = await showConfirmDialog(
      context,
      title: "Delete member",
      message: "Are you sure you want to delete ${member.name}?",
      confirmLabel: "Delete",
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    final cubit = context.read<MembersCubit>();
    await cubit.delete(member.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${member.name} deleted successfully")),
    );
  }

  Future<void> _handleUpdate(Member member) async {
    final nameController = TextEditingController(text: member.name);
    final emailController = TextEditingController(text: member.email);
    var paymentStatus = member.paymentStatus;

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Update Member'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInputField(
                    controller: nameController,
                    hintText: "Name",
                  ),
                  CustomInputField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  DropdownButtonFormField<MemberPaymentStatus>(
                    initialValue: paymentStatus,
                    items: MemberPaymentStatus.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status.label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => paymentStatus = value);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Payment Status",
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text("Close"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );

    if (saved != true || !mounted) return;

    final updated = member.copyWith(
      name: nameController.text,
      email: emailController.text,
      paymentStatus: paymentStatus,
    );
    final cubit = context.read<MembersCubit>();
    await cubit.update(updated);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${updated.name} updated successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        leadingWidth: 300,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Member List",
            style: TextStyle(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColor.disableColor,
              ),
              onChanged: (query) => context.read<MembersCubit>().search(query),
            ),
            Expanded(
              child: BlocBuilder<MembersCubit, MembersState>(
                builder: (context, state) {
                  return switch (state) {
                    MembersLoading() => LoadingHelper.defaultLoading(),
                    MembersError() => Center(child: Text(state.message)),
                    MembersLoaded() => _MemberListView(
                      members: state.members,
                      canModify: widget.viewerRole == UserRole.manager,
                      onDelete: _handleDelete,
                      onUpdate: _handleUpdate,
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders a loaded member list; [canModify] gates the update/delete popup
/// menu (managers only — members see the same list read-only).
class _MemberListView extends StatelessWidget {
  final List<Member> members;
  final bool canModify;
  final void Function(Member member) onDelete;
  final void Function(Member member) onUpdate;

  const _MemberListView({
    required this.members,
    required this.canModify,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final member = members[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColor.disableColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: CachedNetworkImageProvider(member.profileImage),
            ),
            title: Text(
              member.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.username),
                Text(member.email),
                Text(
                  "Joined: ${DateFormat.yMMMd().format(member.joiningDate)}",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  "Payment: ${member.paymentStatus.label} (${DateFormat.yMMMd().format(member.paymentDate)})",
                  style: TextStyle(
                    fontSize: 12,
                    color: member.paymentStatus == MemberPaymentStatus.due
                        ? AppColor.errorColor
                        : AppColor.successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            trailing: canModify
                ? PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "delete") onDelete(member);
                      if (value == "update") onUpdate(member);
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: "update",
                        child: Text("Update"),
                      ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }
}
