import 'package:get/get_navigation/get_navigation.dart';
import 'package:sof_app/modules/user_page/user_page.dart';
import 'package:sof_app/modules/user_page/user_page_binding.dart';
import 'package:sof_app/route/app_route.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoute.userPage,
      page: () => UserPage(),
      binding: UserPageBinding(),
    ),
  ];
}
