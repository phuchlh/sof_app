import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utils/helper.dart';
import '../../utils/images.dart';
import '../reputation_history/reputation_history_controller.dart';
import '../reputation_history/reputation_history_page.dart';
import 'user_page_controller.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filteredUsers = controller.filteredUsers;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 0),
            child: Row(
              children: [
                // serach bar
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.filterUsersByName(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search users',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.filterUsersByName('');
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ToggleSwitch(
                    key: ValueKey(controller.selectedToggleIndex.value),
                    minWidth: 48.0,
                    minHeight: 45.0,
                    initialLabelIndex: controller.selectedToggleIndex.value,
                    cornerRadius: 10.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    icons: [Icons.all_inbox, Icons.bookmark_border_outlined],
                    iconSize: 30.0,
                    activeBgColors: [
                      [Colors.black45, Colors.black26],
                      [Colors.yellow, Colors.orange],
                    ],
                    animate: true,
                    curve: Curves.bounceInOut,
                    onToggle: (index) {
                      if (index != null) {
                        controller.toggleFilterByIndex(index);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // 👇 Content section
          Expanded(
            child:
                controller.isLoading.value && filteredUsers.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : filteredUsers.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(Images.noData, width: 200, height: 200),
                          Text(
                            controller.showBookmarkedOnly.value
                                ? 'No bookmarked users'
                                : 'No users found',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: () => controller.refreshUsers(),
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount:
                            filteredUsers.length +
                            (controller.hasMore.value &&
                                    !controller.showBookmarkedOnly.value
                                ? 1
                                : 0),
                        itemBuilder: (context, index) {
                          if (index == filteredUsers.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final user = filteredUsers[index];
                          return GestureDetector(
                            onTap: () {
                              final reputationController = Get.put(
                                ReputationHistoryController(),
                              );
                              reputationController.setSelectedUserId(
                                user.userId ?? 0,
                              );
                              reputationController.userModel.value = user;
                              Get.to(() => const ReputationHistoryPage());
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    user.profileImage ?? '',
                                  ),
                                ),
                                title: Text(
                                  user.displayName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reputation: ${Helper.formatReputation(user.reputation ?? 0)}',
                                    ),
                                    if (user.location != null)
                                      Text('Location: ${user.location}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => IconButton(
                                        icon: Icon(
                                          controller.isBookmarked(
                                                user.userId ?? 0,
                                              )
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          color:
                                              controller.isBookmarked(
                                                    user.userId ?? 0,
                                                  )
                                                  ? context.theme.primaryColor
                                                      .withAlpha(150)
                                                  : null,
                                        ),
                                        onPressed:
                                            () =>
                                                controller.toggleBookmark(user),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          ),
        ],
      );
    });
  }
}
