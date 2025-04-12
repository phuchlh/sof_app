import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sof_app/main_binding.dart';
import 'package:sof_app/modules/user_page/user_page.dart';
import 'package:sof_app/route/app_page.dart';
import 'package:sof_app/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SFO App',
      getPages: AppPages.pages,
      theme: MaterialTheme(TextTheme()).light(),
      initialBinding: MainBinding(),
      home: Builder(
        builder: (context) {
          return Scaffold(body: UserPage());
        },
      ),
    );
  }
}
