import 'package:drink_store/app/models/cart_item_model.dart';
import 'package:drink_store/app/models/order_model.dart';
import 'package:drink_store/pages/home/result/orders_result.dart';

import '../../../app/consts/endpoints.dart';
import '../../../app/untils/http_manager.dart';

class OrdersRepository{
  final httpManager = HttpManager();


  Future<OrdersResult<List<CartItemModel>>> getOrdersItems(
      {required String orderId, required String token}
  )async{
    final response = await httpManager.request(
      url: EndPoint.getOrdersItems,
      method: HttpRequests.post,
      body: {
        "orderId": orderId,
      },
      headers: {
        "X-Parse-Session-Token": token,
      }
    );

    if (response['result'] != null) {
      List<CartItemModel> items = List<Map<String, dynamic>>.from(response['result']).map(CartItemModel.fromJson).toList();
      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return const OrdersResult.failure('Erro ao buscar pedidos');
    }
  }




  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String userId, required String token}
  ) async {
    final response = await httpManager.request(
      url: EndPoint.getAllOrders,
      method: HttpRequests.post,
      body: {
        "user": userId,
      },
      headers: {
        "X-Parse-Session-Token": token,
      }
    );

    if (response['result'] != null) {
      List<OrderModel> orders = List<Map<String, dynamic>>.from(response['result']).map(OrderModel.fromJson).toList();
      return OrdersResult.success(orders);
    } else {
      return const OrdersResult.failure('Erro ao buscar pedidos');
    }
  }

}