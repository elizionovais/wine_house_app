import 'package:drink_store/app/models/category_model.dart';
import 'package:drink_store/app/untils/untils_price.dart';
import 'package:drink_store/pages/home/result/home_result.dart';
import 'package:get/get.dart';

import '../../../app/models/item_model.dart';
import '../repository/home_repository.dart';

class HomeTabController extends GetxController {
  final RxBool isLoadingProduct = false.obs;
  final RxBool isLoading = false.obs;
  final homeRepository = HomeRepository();
  List<CategoryModel> categories = [];
  UntilPrice untilPrice = UntilPrice();
  CategoryModel? categorySelected;
  List<ItemModel> get allProducts => categorySelected?.items ?? [];
  //
  String categoryinit = 'Tinto';
  //

  //verificar os ultimos itens, para evitar que seja feita uma nova requisição
  bool get isLastPage {
    if (categorySelected!.items.length < 6) return true;
    return categorySelected!.page * 6 > allProducts.length;
  }

  //variavel para a barra de pesquisa
  final RxString search = ''.obs;

  @override
  void onInit() {
    super.onInit();
    //debounce atualiza os valores da barra de pesquisa no interval setado
    debounce(search, (_) => filterByTitle(), time: const Duration(milliseconds: 500));

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    categorySelected = category;
    update();
    //isso foi feito para que nao seja requisitado itens ja buscados
    if (categorySelected!.items.isNotEmpty) return;
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    // isLoading.value = true;
    HomeResult<CategoryModel> homeResult = await homeRepository.getAllCategory();

    isLoading.value = false;

    homeResult.when(
      success: (data) {
        categories.assignAll(data);
        if (categories.isNotEmpty) return;
        selectCategory(categories.first);
      },
      failure: (message) {
        untilPrice.showToast(message: message, type: true);
      },
    );
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      // isLoading.value = true;
    }

    Map<String, dynamic> body = {'page': categorySelected!.page, 'categoryId': categorySelected!.id, 'itemsPerPage': 6};

    if (search.value.isNotEmpty) {
      body['title'] = search.value;

      if (categorySelected!.id.isEmpty) {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> homeResult = await homeRepository.getAllProducts(body);

    isLoading.value = false;

    homeResult.when(
      success: (data) {
        categorySelected!.items.addAll(data);
      },
      failure: (message) {
        untilPrice.showToast(message: message, type: true);
      },
    );
  }

  void loadMoreProducts() {
    categorySelected!.page++;
    getAllProducts(canLoad: false);
  }

  void filterByTitle() {
    for (var category in categories) {
      category.items.clear();
      category.page = 0;
    }

    if (search.value.isEmpty) {
      categories.removeAt(0);
    } else {
      CategoryModel? c = categories.firstWhereOrNull((cat) => cat.id == '');
      if (c == null) {
        final allProductsCategory = CategoryModel(
          id: '',
          title: 'Todos',
          items: [],
          page: 0,
        );

        categories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.page = 0;
      }
    }

    selectCategory(categories.first);
    update();
    getAllProducts();
  }
}
