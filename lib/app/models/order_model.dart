import 'package:drink_store/app/models/cart_item_model.dart';

class OrderModel {
  String id;
  DateTime createDate;
  DateTime updateDate;
  List<CartItemModel> items;
  String status;
  String copyAndPaste;
  double total;
  String? qrCode;

  OrderModel({
    required this.id,
    required this.createDate,
    required this.updateDate,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    this.qrCode,
  });

  bool get overDue => updateDate.isBefore(DateTime.now());

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createDate: DateTime.parse(json['createdAt']),
      updateDate: DateTime.parse(json['due']),
      items: (json['items'] as List).map((e) => CartItemModel.fromJson(e)).toList(),
      status: json['status'],
      copyAndPaste: json['copiaecola'],
      total: json['total'],
      qrCode: json['qrCodeImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createDate.toIso8601String(),
      'due': updateDate.toIso8601String(),
      'items': items.map((e) => e.toJson()).toList(),
      'status': status,
      'copiaecola': copyAndPaste,
      'total': total,
      'qrCodeImage': qrCode,
    };
  }
}
