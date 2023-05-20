import 'package:drink_store/app/models/cart_item_model.dart';
import 'package:drink_store/app/models/order_model.dart';

import '../../../app/consts/endpoints.dart';
import '../../../app/untils/http_manager.dart';
import '../result/cart_result.dart';

class CartRepository {
  HttpManager httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({required String token, required String userId}) async {
    final response = await httpManager.request(
        url: EndPoint.getCartItems,
        method: HttpRequests.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'user': userId});

    if (response['result'] != null) {
      List<CartItemModel> data =
          (List<Map<String, dynamic>>.from(response['result'])).map(CartItemModel.fromJson).toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return const CartResult.failure('Ocorreu um erro ao buscar os produtos do carrinho, tente novamente mais tarde.');
    }
  }

  Future<bool> modifyItemQuantity({required String token, required String cartItemId, required int quantity}) async {
    final response = await httpManager.request(
        url: EndPoint.modifyItemQuantity,
        method: HttpRequests.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'cartItemId': cartItemId, 'quantity': quantity});

    return response.isEmpty;
  }

  Future<CartResult<String>> addItem(
      {required String token, required String userId, required String productId, required int quantity}) async {
    final response = await httpManager.request(
        url: EndPoint.addItemToCart,
        method: HttpRequests.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'user': userId, 'productId': productId, 'quantity': quantity});

    if (response['result'] != null) {
      return CartResult<String>.success(response['result']['id']);
    } else {
      return const CartResult.failure(
          'Ocorreu um erro ao adicionar o produto ao carrinho, tente novamente mais tarde.');
    }
  }

  Future<CartResult<OrderModel>> checkout({required String token, required double total}) async {
    final response = await httpManager.request(
        url: EndPoint.checkout,
        method: HttpRequests.post,
        headers: {'X-Parse-Session-Token': token},
        body: {'total': total});

    if (response['result'] != null) {
      final order = OrderModel.fromJson(response['result']);
      return CartResult<OrderModel>.success(order);
    } else {
      return const CartResult.failure('Ocorreu um erro ao finalizar a compra, tente novamente mais tarde.');
    }
  }
}
