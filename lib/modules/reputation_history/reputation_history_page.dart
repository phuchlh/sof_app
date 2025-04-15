import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/gap.dart';
import '../../utils/helper.dart';
import 'reputation_history_controller.dart';
import 'widgets/analysis_widget.dart';
import 'widgets/profile_widget.dart';
import 'widgets/reputation_widget.dart';

class ReputationHistoryPage extends GetView<ReputationHistoryController> {
  const ReputationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reputation"),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isUserBookmarked.value ? Icons.bookmark : Icons.bookmark_border,
                color: controller.isUserBookmarked.value ? context.theme.primaryColor : null,
              ),
              onPressed: () => controller.toggleBookmark(controller.userModel.value),
            ),
          ),
        ],
      ),

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
                        controller.userModel.value.profileImage ?? 'https://i.imgur.com/Y1LspuF.png',
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: k10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userModel.value.displayName ?? 'User',
                            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Member for ${Helper.timeAgoFromUnix(controller.userModel.value.creationDate ?? 0)}',
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          Gap(k6),

                          controller.userModel.value.lastAccessDate != null
                              ? _RowText(
                                icon: Icons.access_time_rounded,
                                size: k16,
                                value: Helper.timeAgoFromUnix(controller.userModel.value.lastAccessDate ?? 0),
                                style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                              )
                              : SizedBox.shrink(),
                        ],
                      ),
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
                children: [ProfileWidget(user: controller.userModel.value), ReputationWidget(), AnalysisWidget()],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _RowText extends StatelessWidget {
  const _RowText({required this.icon, required this.value, this.size, this.style});

  final IconData icon;
  final String value;
  final double? size;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: context.theme.iconTheme.color?.withAlpha(150), size: size ?? k16),
        Gap(k4),
        Text(value, style: style ?? context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
