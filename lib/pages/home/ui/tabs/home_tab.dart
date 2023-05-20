import 'package:drink_store/app/components/app_name_widget.dart';
import 'package:drink_store/app/components/custom_shimmer.dart';
import 'package:drink_store/app/routes/app_routes.dart';
import 'package:drink_store/app/themes/main_theme.dart';
import 'package:drink_store/pages/home/controller/home_tab_controller.dart';
import 'package:drink_store/pages/home/ui/components/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/data/item_data.dart' as data;
import '../../controller/home_page_controller.dart';
import '../components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool search = false;
  String categotySelected = 'Tinto';
  final TextEditingController searchController = TextEditingController();
  final pageController = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: ColorTheme.primary,
            elevation: 1,
            title: const Hero(
              tag: 'app_name',
              child: AppName(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      search = !search;
                    });
                  },
                  icon: const Icon(Icons.search, color: Colors.white, size: 30))
            ]),
        body: Column(
          children: [
            // Barra de pesquisa
            GetBuilder<HomeTabController>(builder: (controller) {
              return Visibility(
                visible: search,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.search.value = value;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Pesquisar',
                      suffixIcon: controller.search.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.search.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.close),
                            )
                          : null,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 21,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                  ),
                ),
              );
            }),
            // Categorias
            GetBuilder<HomeTabController>(builder: (controller) {
              return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.only(
                    left: 25,
                  ),
                  height: 40,
                  child: !controller.isLoading.value
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CategoryTile(
                            title: data.categorys[index],
                            selected: data.categorys[index] == controller.categoryinit,
                            onPressed: () {
                              controller.categoryinit = data.categorys[index];
                            },
                          ),
                          separatorBuilder: (_, index) => const SizedBox(width: 10),
                          itemCount: data.categorys.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            5,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10, bottom: 10),
                              child: CustomShimmer(
                                height: double.infinity,
                                width: 150,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ));
            }),
            // Lista de produtos
            GetBuilder<HomeTabController>(builder: (controller) {
              return Expanded(
                child: !controller.isLoadingProduct.value
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          // Carrega mais produtos quando chegar no final da lista
                          if (((index + 1) == controller.allProducts.length) && !controller.isLastPage) {
                            controller.loadMoreProducts();
                          }

                          return ItemTile(
                            item: data.items[index],
                            onPressed: () {},
                            onTap: () {
                              Get.offAllNamed(
                                AppRoutes.product,
                                arguments: data.items[index],
                              );
                            },
                          );
                        },
                        itemCount: data.items.length,
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(
                          10,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
              );
            })
          ],
        ));
  }
}
