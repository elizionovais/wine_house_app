const String mainUrl = 'https://parseapi.back4app.com/functions';

abstract class EndPoint {
  static const String login = '$mainUrl/login';
  static const String register = '$mainUrl/signup';
  static const String validateToken = '$mainUrl/validate-token';
  static const String resetPassword = '$mainUrl/reset-password';
  static const String getAllcategories = '$mainUrl/get-category-list';
  static const String getAllProducts = '$mainUrl/get-product-list';
  static const String getCartItems = '$mainUrl/get-cart-items';
  static const String addItemToCart = '$mainUrl/add-item-to-cart';
  static const String modifyItemQuantity = '$mainUrl/modify-item-quantity';
  static const String checkout = '$mainUrl/checkout';
  static const String getAllOrders = '$mainUrl/get-orders';
  static const String getOrdersItems = '$mainUrl/get-orders-items';
  static const String changePassword = '$mainUrl/change-password';
}
