import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helper.dart';
import 'reputation_history_controller.dart';

class ReputationHistoryPage extends GetView<ReputationHistoryController> {
  const ReputationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reputation History')),
      body: Obx(() {
        final reputationHistory = controller.reputationHistory;
        return reputationHistory.isEmpty && !controller.isLoading.value
            ? const Center(child: Text('No reputation history found'))
            : RefreshIndicator(
              onRefresh: () => controller.refreshReputationHistory(),
              child: ListView.builder(
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
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      leading:
                          (repu.reputationChange ?? 0) > 0
                              ? Icon(Icons.trending_up, color: Colors.green)
                              : (repu.reputationChange ?? 0) < 0
                              ? Icon(Icons.trending_down, color: Colors.red)
                              : Icon(Icons.trending_flat, color: Colors.grey),
                      title: Text(
                        '$repuType reputation',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${repu.reputationHistoryType} on post ${repu.postId}',
                      ),
                      trailing: Text(
                        Helper.timeAgoFromUnix(repu.creationDate ?? 0),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),

                    // ListTile(
                    //   title: Text(
                    //     repu.reputationHistoryType ?? 'Unknown',
                    //     style: const TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    //   subtitle: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Reputation Change: ${repu.creationDate}'),
                    //       if (repu.creationDate != null)
                    //         Text(
                    //           'Date: ${Helper.timeAgoFromUnix(repu.creationDate ?? 0)}',
                    //         ),
                    //     ],
                    //   ),
                    //   trailing: Text(
                    //     repu.reputationChange != null
                    //         ? '${repu.reputationChange! > 0 ? '+' : ''}${repu.reputationChange}'
                    //         : '0',
                    //     style: TextStyle(
                    //       color:
                    //           repu.reputationChange != null
                    //               ? repu.reputationChange! > 0
                    //                   ? Colors.green
                    //                   : Colors.red
                    //               : Colors.grey,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  );
                },
              ),
            );
      }),
    );
  }
}
