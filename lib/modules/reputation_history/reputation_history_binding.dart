import 'package:get/get.dart';
import 'reputation_history_controller.dart';

class ReputationHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReputationHistoryController>(() => ReputationHistoryController());
  }
}
