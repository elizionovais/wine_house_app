import 'package:drink_store/app/models/cart_item_model.dart';
import 'package:drink_store/app/models/order_model.dart';
import 'package:drink_store/app/untils/untils_price.dart';
import 'package:drink_store/pages/home/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/components/payment_dialog.dart';
import '../../../app/models/item_model.dart';
import '../../login/controller/login_controller.dart';
import '../result/cart_result.dart';

class CartTabController extends GetxController {
  final cartRepository = CartRepository();
  final loginController = Get.find<LoginController>();
  final UntilPrice untilPrice = UntilPrice();
  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> response =
        await cartRepository.getCartItems(token: loginController.user.token!, userId: loginController.user.id!);

    response.when(success: (data) {
      cartItems = data;
      update();
    }, failure: (message) {
      untilPrice.showToast(message: message, type: true);
    });
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((element) => element.item.id == item.id);
  }

  Future<bool> changeItemQuantity({
    required CartItemModel cartItem,
    required int quantity,
  }) async {
    final response = await cartRepository.modifyItemQuantity(
        token: loginController.user.token!, cartItemId: cartItem.id!, quantity: quantity);

    if (response) {
      if (quantity == 0) {
        cartItems.removeWhere((element) => element.id == cartItem.id!);
      } else {
        cartItems.firstWhere((element) => element.id == cartItem.id!).quantity = quantity;
      }
      update();
    } else {
      untilPrice.showToast(message: 'Ocorreu um erro ao modificar a quantidade do produto.', type: true);
    }

    return response;
  }

  Future<void> addItem({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int index = getItemIndex(item);
    if (index >= 0) {
      final product = cartItems[index];
      await changeItemQuantity(cartItem: product, quantity: (product.quantity + quantity));
    } else {
      final CartResult<String> response = await cartRepository.addItem(
          token: loginController.user.token!, userId: loginController.user.id!, productId: item.id, quantity: quantity);

      response.when(success: (data) {
        cartItems.add(
          CartItemModel(item: item, quantity: quantity, id: data),
        );
      }, failure: (message) {
        untilPrice.showToast(message: message, type: true);
      });
    }
  }

  double totalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future checkoutCart() async {
    CartResult<OrderModel> response = await cartRepository.checkout(
      token: loginController.user.token!,
      total: totalPrice(),
    );

    response.when(success: (data) {
      cartItems.clear();
      update();
      showDialog(
        context: Get.context!,
        builder: (_) {
          return PaymentDialog(
            order: data,
          );
        },
      );
    }, failure: (message) {
      untilPrice.showToast(message: message);
    });
  }
}
