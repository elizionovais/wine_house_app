import 'package:get/get.dart';

import '../controller/cart_tab_controller.dart';


class CartTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartTabController>(CartTabController());
  }
}