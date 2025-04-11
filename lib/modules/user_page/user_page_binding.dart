import 'package:get/get.dart';
import 'package:sof_app/modules/user_page/user_page_controller.dart';

class UserPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPageController>(() => UserPageController());
  }
}
