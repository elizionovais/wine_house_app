import 'package:drink_store/app/components/custom_buttom.dart';
import 'package:drink_store/app/themes/main_theme.dart';
import 'package:drink_store/pages/home/controller/cart_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/data/item_data.dart' as data;

import '../../../../app/untils/untils_price.dart';
import '../components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  UntilPrice untilPrice = UntilPrice();
  final cartController = Get.find<CartTabController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartTabController>(builder: (controller) {
              if (controller.cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
                      Text('Carrinho vazio', style: TextStyle(fontSize: 20, color: Colors.grey[400])),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemBuilder: (context, index) => CartTile(
                        //cartItem: controller.cartItems[index],
                        cartItem: data.cartItems[index],
                      ),
                  //itemCount: controller.cartItems.length
                  itemCount: data.cartItems.length);
            }),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade600, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              GetBuilder<CartTabController>(builder: (controller) {
                return cartController.cartItems.isEmpty
                    ? const SizedBox()
                    : Text('Total: ${untilPrice.localPrice(controller.totalPrice())}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorTheme.primary));
              }),
              const SizedBox(height: 16),
              CustomButtom(
                  title: 'Finalizar compra',
                  onPressed: cartController.cartItems.isEmpty
                      ? null
                      : () async {
                          bool? result = await _showDialog();

                          if (result ?? false) {
                            cartController.checkoutCart();
                          } else {
                            untilPrice.showToast(message: 'Pedido não confirmado');
                          }
                        }),
            ]),
          )
        ],
      ),
    );
  }

  Future<bool?> _showDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Finalizar compra'),
        content: const Text('Deseja finalizar a compra?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}
