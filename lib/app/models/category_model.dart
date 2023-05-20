import 'package:drink_store/app/models/item_model.dart';

class CategoryModel {
  String id;
  String title;

  List<ItemModel> items;
  int page;

  CategoryModel({required this.id, required this.title, this.items = const [], this.page = 0});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      items: json['items'] != null ? (json['items'] as List).map((i) => ItemModel.fromJson(i)).toList() : [],
      page: json['page'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'items': items.map((e) => e.toJson()).toList(),
      'page': page,
    };
  }
}
