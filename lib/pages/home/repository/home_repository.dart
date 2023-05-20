import 'package:drink_store/app/models/category_model.dart';
import 'package:drink_store/pages/home/result/home_result.dart';

import '../../../app/consts/endpoints.dart';
import '../../../app/models/item_model.dart';
import '../../../app/untils/http_manager.dart';

class HomeRepository {
  HttpManager httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategory() async {
    final response = await httpManager.request(
      url: EndPoint.getAllcategories,
      method: HttpRequests.post,
    );

    if (response['result'] != null) {
      List<CategoryModel> data = (List<Map<String, dynamic>>.from(response['result'])).map((e) => CategoryModel.fromJson(e)).toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return const HomeResult.failure(
      'Ocorreu um erro ao buscar as categorias, tente novamente mais tarde.');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(Map<String, dynamic> body) async {
    final response = await httpManager.request(
      url: EndPoint.getAllProducts,
      method: HttpRequests.post,
      body: body,
    );

    if (response['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(response['result'])).map(ItemModel.fromJson).toList();
      return HomeResult<ItemModel>.success(data);
    } else {
      return const HomeResult.failure(
      'Ocorreu um erro ao buscar os produtos, tente novamente mais tarde.');
    }
  }
}
