import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sof_app/modules/user_page/user_page_controller.dart';
import 'package:sof_app/models/user_model.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Overflow Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshUsers(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.users.isEmpty && !controller.isLoading.value) {
          return const Center(child: Text('No users found'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshUsers(),
          child: ListView.builder(
            itemCount:
                controller.users.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.users.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!controller.isLoading.value) {
                    controller.loadUsers();
                  }
                });
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final user = controller.users[index];
              return _UserListItem(user: user);
            },
          ),
        );
      }),
    );
  }
}

class _UserListItem extends StatelessWidget {
  final UserModel user;

  const _UserListItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profileImage ?? ''),
        ),
        title: Text(
          user.displayName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reputation: ${user.reputation}'),
            if (user.location != null) Text('Location: ${user.location}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.link),
          onPressed: () {
            if (user.link != null) {
              Get.dialog(
                AlertDialog(content: Text('Open user link: ${user.link}')),
              );
            }
          },
        ),
      ),
    );
  }
}
