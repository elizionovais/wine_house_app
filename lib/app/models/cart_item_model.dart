import 'package:drink_store/app/models/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;
  String? id;

  CartItemModel({required this.item, required this.quantity, this.id});

  double totalPrice() {
    return item.price * quantity;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      item: ItemModel.fromJson(json['product']),
      quantity: json['quantity'],
      id: json['id']
    );
  } 

  Map<String, dynamic> toJson() {
    return {
      'product': item.toJson(),
      'quantity': quantity,
      'id': id
    };
  }
}
