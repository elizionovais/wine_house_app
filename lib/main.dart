import 'package:drink_store/pages/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_routes.dart';
import 'app/themes/main_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Get.put is a method that provides a new instance of the class
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //getmaterialapp is a widget that provides many useful features from getx
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YourWineHouse',
      theme: ThemeData(
        primarySwatch: ColorTheme.primarySwatch,
        scaffoldBackgroundColor: ColorTheme.primary,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
