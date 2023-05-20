class ItemModel {
  String id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  bool favorite;

  ItemModel({
    this.id = '',
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.quantity = 0,
    this.favorite = false,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      image: json['picture'],
      price: json['price'],
      quantity: json['quantity'],
      favorite: json['favorite'],
    );
  }


  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'description': description,
        'picture': image,
        'price': price,
        'quantity': quantity,
        'favorite': favorite,
      };
}
