import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sof_app/models/reputation_model.dart';
import 'package:sof_app/models/user_model.dart';
import 'package:sof_app/modules/reputation_history/widgets/analysis_widget.dart';
import 'package:sof_app/modules/reputation_history/widgets/profile_widget.dart';
import 'package:sof_app/widgets/shimmer_widget.dart';

import '../../utils/helper.dart';
import '../../utils/gap.dart';
import 'reputation_history_controller.dart';

class ReputationHistoryPage extends GetView<ReputationHistoryController> {
  const ReputationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        final reputationHistory = controller.reputationHistory;
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: k20, vertical: k10),
              child: Row(
                children: [
                  SizedBox(
                    width: k100,
                    height: k100,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        controller.userModel.value.profileImage ??
                            'https://i.imgur.com/Y1LspuF.png',
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: k10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userModel.value.displayName ?? 'User',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Member for ${Helper.timeAgoFromUnix(controller.userModel.value.creationDate ?? 0)}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(k6),

                        controller.userModel.value.lastAccessDate != null
                            ? _RowText(
                              icon: Icons.access_time_rounded,
                              size: k16,
                              value: Helper.timeAgoFromUnix(
                                controller.userModel.value.lastAccessDate ?? 0,
                              ),
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Gap(k10),

            // generate tab bar
            TabBar(
              controller: controller.tabController,
              indicatorColor: context.theme.primaryColor,
              labelColor: context.theme.primaryColor,
              unselectedLabelColor: context.theme.iconTheme.color,
              tabs: controller.tabsData,
            ),

            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  ProfileWidget(user: controller.userModel.value),
                  _ReputationWidget(
                    reputationHistory: reputationHistory,
                    controller: controller,
                  ),
                  AnalysisWidget(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ReputationWidget extends StatelessWidget {
  const _ReputationWidget({
    required this.reputationHistory,
    required this.controller,
  });

  final RxList<ReputationModel> reputationHistory;
  final ReputationHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final reputationHistory = controller.reputationHistory;

      if (controller.isReputationLoading.value) {
        return const Expanded(
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (reputationHistory.isEmpty && !controller.isLoading.value) {
        return const Center(child: Text('No reputation history found'));
      }

      return RefreshIndicator(
        onRefresh: () => controller.refreshReputationHistory(),
        child: ListView.builder(
          controller: controller.scrollController,
          itemCount:
              reputationHistory.length + (controller.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == reputationHistory.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final repu = reputationHistory[index];
            final repuType =
                (repu.reputationChange ?? 0) > 0
                    ? "+${repu.reputationChange}"
                    : (repu.reputationChange ?? 0) < 0
                    ? "${repu.reputationChange}"
                    : "0";

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: ListTile(
                leading:
                    (repu.reputationChange ?? 0) > 0
                        ? const Icon(Icons.trending_up, color: Colors.green)
                        : (repu.reputationChange ?? 0) < 0
                        ? const Icon(Icons.trending_down, color: Colors.red)
                        : const Icon(Icons.trending_flat, color: Colors.grey),
                title: Text(
                  '$repuType reputation',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${repu.reputationHistoryType} on post ${repu.postId}',
                ),
                trailing: Text(
                  Helper.timeAgoFromUnix(repu.creationDate ?? 0),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class _RowText extends StatelessWidget {
  const _RowText({
    required this.icon,
    required this.value,
    this.size,
    this.style,
  });

  final IconData icon;
  final String value;
  final double? size;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: context.theme.iconTheme.color?.withAlpha(150),
          size: size ?? k16,
        ),
        Gap(k4),
        Text(
          value,
          style:
              style ??
              context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
