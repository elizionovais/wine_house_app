import 'package:drink_store/app/untils/untils_price.dart';
import 'package:drink_store/pages/home/repository/orders_repository.dart';
import 'package:drink_store/pages/home/result/orders_result.dart';
import 'package:get/get.dart';

import '../../../app/models/order_model.dart';
import '../../login/controller/login_controller.dart';

class OrdersTabController extends GetxController {
  List<OrderModel> orders = [];
  final ordersRepository = OrdersRepository();
  final loginController = Get.find<LoginController>();
  final untilPrice = UntilPrice();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.getAllOrders(
      userId: loginController.user.id!,
      token: loginController.user.token!,
    );

    result.when(
      success: (data) {
        //sort by date - para ordenar por data
        orders = data..sort((a, b) => b.createDate.compareTo(a.createDate));
        update();
      },
      failure: (message) {
        untilPrice.showToast(message: message, type: true);
      },
    );
  }
}
