import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart' show CustomAppBar;
import 'package:mass_management/utils/app_color.dart' show AppColor;

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserModel> displayedUsers = List.from(users);
  TextEditingController searchController = TextEditingController();

  // Confirm before deleting
  Future<void> _confirmDelete(UserModel user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${user.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _deleteUser(user);
    }
  }

  // Confirm before updating
  Future<void> _confirmUpdate(UserModel user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Update"),
        content: Text("Do you want to update ${user.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Update", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _updateUser(user);
    }
  }

  void _deleteUser(UserModel user) {
    setState(() {
      displayedUsers.remove(user);
      users.remove(user); // remove from main list as well
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${user.name} deleted successfully")),
    );
  }

  void _updateUser(UserModel user) {
    // Demo: simple dialog to simulate update
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Name"),
              controller: TextEditingController(text: user.name),
              onChanged: (value) => user.name = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Email"),
              controller: TextEditingController(text: user.email),
              onChanged: (value) => user.email = value,
            ),
            DropdownButtonFormField<String>(
              value: user.paymentStatus,
              items: ["Due", "Clear"].map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) user.paymentStatus = value;
              },
              decoration: const InputDecoration(labelText: "Payment Status"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          TextButton(
            onPressed: () {
              setState(() {}); // Refresh UI
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${user.name} updated successfully")),
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _filterUsers(String query) {
    final filtered = users.where((user) {
      final nameMatch = user.name.toLowerCase().contains(query.toLowerCase());
      final usernameMatch = user.username.toLowerCase().contains(query.toLowerCase());
      final emailMatch = user.email.toLowerCase().contains(query.toLowerCase());
      return nameMatch || usernameMatch || emailMatch;
    }).toList();

    setState(() {
      displayedUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        leadingWidth: 300,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Member List",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: _filterUsers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedUsers.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final user = displayedUsers[index];
                return Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
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
                        const SizedBox(height: 4),
                        Text(
                          "Payment: ${user.paymentStatus} (${DateFormat.yMMMd().format(user.paymentDate)})",
                          style: TextStyle(
                            fontSize: 12,
                            color: user.paymentStatus == "Due" ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "delete") _confirmDelete(user);
                        if (value == "update") _confirmUpdate(user);
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserModel {
  String name;
  final String username;
  String email;
  final String profileImage;
  final DateTime joiningDate;
  String paymentStatus;
  DateTime paymentDate;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.joiningDate,
    this.paymentStatus = "Due",
    DateTime? paymentDate,
  }) : paymentDate = paymentDate ?? DateTime.now();
}

// Dummy user list
final List<UserModel> users = [
  UserModel(
    name: "John Doe",
    username: "@johnd",
    email: "john.doe@example.com",
    profileImage: "https://i.pravatar.cc/150?img=1",
    joiningDate: DateTime(2023, 4, 15),
    paymentStatus: "Clear",
    paymentDate: DateTime(2025, 9, 30),
  ),
  UserModel(
    name: "Jane Smith",
    username: "@janes",
    email: "jane.smith@example.com",
    profileImage: "https://i.pravatar.cc/150?img=2",
    joiningDate: DateTime(2022, 12, 5),
    paymentStatus: "Due",
    paymentDate: DateTime(2025, 10, 5),
  ),
];
