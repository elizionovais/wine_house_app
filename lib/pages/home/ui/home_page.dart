import 'package:drink_store/app/themes/main_theme.dart';
import 'package:drink_store/pages/home/ui/tabs/cart_tab.dart';
import 'package:drink_store/pages/home/ui/tabs/home_tab.dart';
import 'package:drink_store/pages/home/ui/tabs/orders_tab.dart';
import 'package:drink_store/pages/home/ui/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_tab_controller.dart';
import '../controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: const [
            HomeTab(),
            CartTab(),
            OrdersTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: controller.tabIndex,
            onTap: (index) {
              controller.pageView(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorTheme.primary,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(100),
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: GetBuilder<CartTabController>(builder: (bagetcontroller) {
                    return Badge(
                      alignment: AlignmentDirectional.topEnd,
                      isLabelVisible: bagetcontroller.cartItems.isNotEmpty,
                      label: Text(
                        bagetcontroller.cartItems.length.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      child: IconButton(
                        constraints: const BoxConstraints(maxHeight: 32, maxWidth: 32),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.shopping_cart,
                        ),
                        onPressed: () {
                          controller.pageView(PageTab.cart);
                        },
                      ),
                    );
                  }),
                  label: 'Carrinho'),
              const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            ],
          );
        }));
  }
}
