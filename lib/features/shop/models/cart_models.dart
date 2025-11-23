import 'product.dart';

class CartItemModel {
  const CartItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
    this.product,
  });

  final int id;
  final int productId;
  final int quantity;
  final Product? product;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: _asInt(json['id']),
      productId: _asInt(json['product_id'] ?? json['productId']),
      quantity: _asInt(json['quantity'] ?? 1),
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CartModel {
  const CartModel({
    required this.id,
    required this.userId,
    required this.items,
  });

  final int id;
  final int userId;
  final List<CartItemModel> items;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: _asInt(json['id']),
      userId: _asInt(json['user_id'] ?? json['userId']),
      items: (json['items'] as List<dynamic>? ?? const [])
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
  }
  return 0;
}
