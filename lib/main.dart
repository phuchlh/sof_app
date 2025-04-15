import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'main_binding.dart';
import 'modules/user_page/user_page.dart';
import 'route/app_page.dart';
import 'theme/theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  // WidgetsFlutterBinding.ensureInitialized();
  // CachedQuery.instance.configFlutter(
  //   storage: await CachedStorage.ensureInitialized(),
  //   config: QueryConfigFlutter(
  //     refetchOnResume: true,
  //     refetchOnConnection: true,
  //   ),
  // );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SFO App',
      getPages: AppPages.pages,
      theme: MaterialTheme(TextTheme()).light(),
      initialBinding: MainBinding(),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: UserPage(),
            );
          },
        ),
      ),
    );
  }
}
