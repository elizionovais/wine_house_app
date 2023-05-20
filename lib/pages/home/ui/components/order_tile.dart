import 'package:drink_store/app/routes/app_routes.dart';
import 'package:drink_store/pages/home/controller/order_controller.dart';
import 'package:drink_store/pages/home/ui/components/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/components/payment_dialog.dart';
import '../../../../app/models/cart_item_model.dart';
import '../../../../app/models/order_model.dart';
import '../../../../app/untils/untils_price.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final UntilPrice _untilPrice = UntilPrice();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      _untilPrice.formatDateTime(order.createDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // Lista de produtos
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 150,
                            child: ListView(
                              children: order.items.map((orderItem) {
                                return _OrderItemWidget(
                                  utilsServices: _untilPrice,
                                  orderItem: orderItem,
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        // Divisão
                        VerticalDivider(
                          color: Colors.grey.shade300,
                          thickness: 2,
                          width: 8,
                        ),

                        // Status do pedido
                        Expanded(
                          flex: 2,
                          child: OrderStatusWidget(
                            status: order.status,
                            isOverdue: order.updateDate.isBefore(DateTime.now()),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Total
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Total ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: _untilPrice.localPrice(order.total),
                        ),
                      ],
                    ),
                  ),

                  // Botão pagamento
                  Visibility(
                    visible: order.status == 'pending_payment' && !order.overDue,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: Get.context!,
                          builder: (_) {
                            return PaymentDialog(
                              order: order,
                            );
                          },
                        );
                      },
                      icon: Image.asset(
                        'assets/images/pix.png',
                        height: 18,
                      ),
                      label: const Text('Ver QR Code Pix'),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UntilPrice utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Get.offAllNamed(AppRoutes.product, arguments: orderItem.item);
        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderItem.item.name),
                  Text(
                    'Qtd: ${orderItem.quantity}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(utilsServices.localPrice(orderItem.totalPrice()))
          ],
        ),
      ),
    );
  }
}
