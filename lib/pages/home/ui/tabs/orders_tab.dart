import 'package:drink_store/pages/home/controller/orders_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/data/item_data.dart' as data;
import '../components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pedidos'),
        ),
        body: GetBuilder<OrdersTabController>(
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.getAllOrders();
              },
              child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  physics: const AlwaysScrollableScrollPhysics(),
                  //controller.orders[index]
                  itemBuilder: (_, index) => OrderTile(order: data.orders[index]),
                  separatorBuilder: (_, index) => const SizedBox(
                        height: 10,
                      ),
                  //controller.orders.length
                  itemCount: data.orders.length),
            );
          }
        ));
  }
}
