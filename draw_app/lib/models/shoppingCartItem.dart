import 'package:draw_app/models/product.dart';

class ShoppingCartItem {
  final Product product;
  final int quantity;

  ShoppingCartItem({required this.product, required this.quantity});

  factory ShoppingCartItem.fromJson(Map<String, dynamic> data) {
    Product product = Product.fromJson(data['product'] as Map<String, dynamic>);
    int quantity = data['quantity'];
    return ShoppingCartItem(product: product, quantity: quantity);
  }
}
