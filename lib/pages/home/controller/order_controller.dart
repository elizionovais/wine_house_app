import 'package:drink_store/app/models/order_model.dart';
import 'package:get/get.dart';

import '../../../app/models/cart_item_model.dart';
import '../../../app/untils/untils_price.dart';
import '../../login/controller/login_controller.dart';
import '../repository/orders_repository.dart';
import '../result/orders_result.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController(this.order);

  final odersRepository = OrdersRepository();
  final loginController = Get.find<LoginController>();
  final untilPrice = UntilPrice();

  Future<void> getOrderItems() async {
    OrdersResult<List<CartItemModel>> result = await odersRepository.getOrdersItems(
      orderId: order.id,
      token: loginController.user.token!,
    );

    result.when(
      success: (data) {
        order.items = data;
        update();
      },
      failure: (message) {
        untilPrice.showToast(message: message, type: true);
      },
    );
  }
}
