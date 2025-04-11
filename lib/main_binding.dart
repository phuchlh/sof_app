import 'package:get/get.dart';
import 'package:sof_app/modules/user_page/user_page_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserPageController());
  }
}
