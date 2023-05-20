import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PageTab {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

class HomePageController extends GetxController {
  late PageController _pageController;
  late RxInt _tabIndex;


  PageController get pageController => _pageController;
  int get tabIndex => _tabIndex.value;

  @override
  void onInit() {
    super.onInit();
    initPage(
      pageController: PageController(initialPage: PageTab.home),
      tabIndex: PageTab.home,
    );
  }

  void initPage({
    required PageController pageController,
    required int tabIndex,
  }) {
    _pageController = pageController;
    _tabIndex = tabIndex.obs;
  }

  void pageView(int page) {
    if (_tabIndex.value == page) return;

    _pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    _tabIndex.value = page;
  }
}
