import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sof_app/modules/user_page/user_page_controller.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('User Page'),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed('/home');
            },
            child: const Text('Go to Home Page'),
          ),
        ],
      ),
    );
  }
}
