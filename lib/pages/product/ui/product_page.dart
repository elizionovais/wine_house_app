import 'package:drink_store/app/components/custom_buttom.dart';
import 'package:drink_store/app/models/item_model.dart';
import 'package:drink_store/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/components/favorite_buttom.dart';
import '../../../app/components/quantity_widget.dart';
import '../../../app/untils/untils_price.dart';
import '../../home/controller/cart_tab_controller.dart';
import '../../home/controller/home_page_controller.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});
  final ItemModel item = Get.arguments;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  UntilPrice untilPrice = UntilPrice();
  final controller = Get.find<HomePageController>();
  final cartTabController = Get.find<CartTabController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Hero(tag: widget.item.image, child: Image.asset(widget.item.image, fit: BoxFit.cover))),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    widget.item.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              untilPrice.localPrice(widget.item.price),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: QuantityWidget(
                                quantity: widget.item.quantity,
                                result: (p0) => widget.item.quantity = p0,
                              ),
                            ),
                            const Spacer(),
                            FavoriteButtom(
                              isFavorite: widget.item.favorite,
                              backgroundColor: Colors.grey[200],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(widget.item.description),
                      ))),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: CustomButtom(
                            icon: Icons.shopping_cart_outlined,
                            title: 'Adicionar ao carrinho',
                            onPressed: () {
                              cartTabController.addItem(
                                item: widget.item,
                                quantity: widget.item.quantity,
                              );
                              Get.back();
                              controller.pageView(PageTab.cart);
                            },
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.home);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          )
        ],
      ),
    );
  }
}
