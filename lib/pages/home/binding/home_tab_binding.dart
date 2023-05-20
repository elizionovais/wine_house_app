import 'package:get/get.dart';

import '../controller/home_tab_controller.dart';

class HomeTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeTabController>(HomeTabController());
  }
}