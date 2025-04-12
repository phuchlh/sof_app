import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sof_app/utils/helper.dart';
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

                  final history = reputationHistory[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      title: Text(
                        history.reputationHistoryType ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reputation Change: ${Helper.formatReputation(history.reputationHistory ?? 0)}',
                          ),
                          if (history.creationDate != null)
                            Text(
                              'Date: ${Helper.formatDate(history.creationDate!)}',
                            ),
                        ],
                      ),
                      trailing: Text(
                        history.reputationHistory != null
                            ? '${history.reputationHistory! > 0 ? '+' : ''}${history.reputationHistory}'
                            : '0',
                        style: TextStyle(
                          color:
                              history.reputationHistory != null
                                  ? history.reputationHistory! > 0
                                      ? Colors.green
                                      : Colors.red
                                  : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
      }),
    );
  }
}
