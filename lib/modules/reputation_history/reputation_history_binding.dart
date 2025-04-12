import 'package:get/get.dart';

class ReputationHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReputationHistoryBinding>(() => ReputationHistoryBinding());
  }
}
