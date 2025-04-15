import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/gap.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/helper.dart';
import '../../utils/images.dart';
import '../../models/user_model.dart';
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(k8, k8, k16, k8),
            child: Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.filterUsersByName(value);
                    },
                    hintText: 'Search users',
                    hintStyle: WidgetStateProperty.all(TextStyle(color: context.theme.colorScheme.onSurfaceVariant)),
                    backgroundColor: WidgetStateProperty.all(context.theme.colorScheme.surfaceContainerHighest.withOpacity(0.3)),
                    elevation: WidgetStateProperty.all(0),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                    leading: Icon(Icons.search, color: context.theme.colorScheme.onSurfaceVariant),
                    trailing: [
                      IconButton(
                        icon: Icon(Icons.clear, color: context.theme.colorScheme.onSurfaceVariant),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.filterUsersByName('');
                        },
                      ),
                    ],
                  ),
                ),
                Gap(k8),
                ToggleSwitch(
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
                    [context.theme.colorScheme.secondary, context.theme.colorScheme.secondaryFixedDim],
                    [context.theme.colorScheme.primary, context.theme.colorScheme.primaryFixedDim],
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    if (index != null) {
                      controller.toggleFilterByIndex(index);
                    }
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child:
                controller.isLoading.value && filteredUsers.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : filteredUsers.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(Images.noData, width: 200, height: 200),
                          Text(
                            controller.showBookmarkedOnly.value ? 'No bookmarked users' : 'No users found',
                            style: context.textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: () => controller.refreshUsers(),
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount:
                            filteredUsers.length + (controller.hasMore.value && !controller.showBookmarkedOnly.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == filteredUsers.length) {
                            return const Center(
                              child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()),
                            );
                          }

                          final user = filteredUsers[index];
                          final isBookmarked = controller.bookmarkedUserIds.contains(user.userId);

                          return GestureDetector(
                            onTap: () {
                              final reputationController = Get.find<ReputationHistoryController>();
                              reputationController.userModel.value = user;
                              reputationController.isUserBookmarked.value = isBookmarked;

                              reputationController.getTopLanguages(userId: user.userId ?? 0);
                              reputationController.setSelectedUserId(user.userId ?? 0);
                              reputationController.loadReputationForChart(userId: user.userId ?? 0);
                              Get.to(() => const ReputationHistoryPage());
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  user.displayName ?? '',
                                                  style: context.textTheme.bodyLarge?.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                                  color:
                                                      isBookmarked
                                                          ? context.theme.colorScheme.primaryFixedDim.withAlpha(255)
                                                          : Colors.grey,
                                                ),

                                                iconSize: k30,
                                                onPressed: () => controller.toggleBookmark(user),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              spacing: 4,
                                              children: [
                                                const Icon(Icons.access_time_outlined, size: 14, color: Colors.grey),
                                                Text(
                                                  Helper.timeAgoFromUnix(user.lastAccessDate ?? 0),
                                                  style: context.textTheme.labelSmall?.copyWith(color: Colors.grey, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              const Text('Reputation', style: TextStyle(color: Colors.grey, fontSize: 13)),
                                              const Spacer(),
                                              Text(
                                                Helper.formatReputation(user.reputation ?? 0),
                                                style: const TextStyle(fontSize: 13, color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Text('Location', style: TextStyle(color: Colors.grey, fontSize: 13)),
                                              const Spacer(),
                                              Text(
                                                user.location ?? 'Unknown',
                                                style: const TextStyle(fontSize: 13, color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    CircleAvatar(radius: 24, backgroundImage: NetworkImage(user.profileImage ?? '')),
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
