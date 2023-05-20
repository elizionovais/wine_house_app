import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/components/quantity_widget.dart';
import '../../../../app/models/cart_item_model.dart';
import '../../../../app/untils/untils_price.dart';
import '../../controller/cart_tab_controller.dart';

class CartTile extends StatefulWidget {
  const CartTile({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  UntilPrice untilPrice = UntilPrice();
  final controller = Get.find<CartTabController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(widget.cartItem.item.image, width: 50, height: 50),
        title: Text(widget.cartItem.item.name),
        subtitle: Text(untilPrice.localPrice(widget.cartItem.totalPrice())),
        trailing: QuantityWidget(
          quantity: widget.cartItem.quantity,
          result: (p0) {
            controller.changeItemQuantity(
              cartItem: widget.cartItem, 
              quantity: p0);
          },
        ),
      ),
    );
  }
}
