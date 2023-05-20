import 'package:get/get.dart';

import '../controller/orders_tab_controller.dart';

class OrdersTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrdersTabController>(OrdersTabController());
  }
}