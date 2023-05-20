import 'package:drink_store/pages/home/binding/cart_tab_binding.dart';
import 'package:drink_store/pages/home/binding/home_tab_binding.dart';
import 'package:drink_store/pages/home/binding/orders_tab_binding.dart';
import 'package:get/get.dart';

import '../../pages/home/binding/home_page_binding.dart';
import '../../pages/home/ui/home_page.dart';
import '../../pages/login/ui/login_page.dart';
import '../../pages/product/ui/product_page.dart';
import '../../pages/register/ui/regiter_page.dart';
import '../../pages/splash/ui/splash_page.dart';

abstract class AppPages {

  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.home,
    page: () => const HomePage(),
    bindings: [
      HomePageBinding(),
      HomeTabBinding(),
      CartTabBinding(),
      OrdersTabBinding()
    ]),
    GetPage(name: AppRoutes.register, page: () => RegisterPage()),
    GetPage(name: AppRoutes.product, page: () => ProductPage()),
  ];

}

abstract class AppRoutes {

  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const product = '/product';

}