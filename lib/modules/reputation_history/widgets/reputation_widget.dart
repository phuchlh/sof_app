import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/gap.dart';
import '../../../utils/helper.dart';
import '../reputation_history_controller.dart';

class ReputationWidget extends GetView<ReputationHistoryController> {
  const ReputationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final reputationHistory = controller.reputationHistory;

      if (controller.isReputationLoading.value) {
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: k10),
            children: List.generate(7, (index) => _ShimmerCard()),
          ),
        );
      }

      if (reputationHistory.isEmpty && !controller.isLoading.value) {
        return const Center(child: Text('No reputation history found'));
      }

      return RefreshIndicator(
        onRefresh: () async {
          controller.isReputationLoading.value = true;
          await controller.refreshReputationHistory();
          controller.isReputationLoading.value = false;
        },
        child:
            controller.isReputationLoading.value
                ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView(
                    padding: const EdgeInsets.only(top: k10),
                    children: List.generate(7, (index) => _ShimmerCard()),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.only(top: k10),
                  controller: controller.scrollController,
                  itemCount:
                      reputationHistory.length +
                      (controller.hasMore.value ? 1 : 0),
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
                        horizontal: k10,
                        vertical: k8,
                      ),
                      elevation: 0,
                      child: ListTile(
                        leading:
                            (repu.reputationChange ?? 0) > 0
                                ? const Icon(
                                  Icons.trending_up,
                                  color: Colors.green,
                                )
                                : (repu.reputationChange ?? 0) < 0
                                ? const Icon(
                                  Icons.trending_down,
                                  color: Colors.red,
                                )
                                : const Icon(
                                  Icons.trending_flat,
                                  color: Colors.grey,
                                ),
                        title: Text(
                          '$repuType reputation',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${controller.getReadableReputationType(repu.reputationHistoryType ?? '')} on post ${repu.postId}',
                        ),
                        trailing: Text(
                          Helper.timeAgoFromUnix(repu.creationDate ?? 0),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
      );
    });
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: k10, vertical: k8),
      elevation: 0,
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        title: Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        subtitle: Container(
          height: 14,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        trailing: Container(
          width: 60,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
