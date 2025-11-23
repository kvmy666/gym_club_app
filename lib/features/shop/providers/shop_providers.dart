import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_config.dart';
import '../data/shop_api.dart';
import '../models/cart_models.dart';
import '../models/product.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  return ShopApi.fetchProducts();
});

final cartProvider = FutureProvider<CartModel>((ref) async {
  return ShopApi.fetchCart();
});

final cartActionProvider =
    Provider<Future<CartModel> Function(CartAction action)>((ref) {
  return (action) async {
    switch (action.type) {
      case CartActionType.add:
        return ShopApi.addToCart(action.productId!, quantity: action.quantity);
      case CartActionType.update:
        return ShopApi.updateCartItem(action.itemId!, action.quantity);
      case CartActionType.remove:
        return ShopApi.removeCartItem(action.itemId!);
    }
  };
});

enum CartActionType { add, update, remove }

class CartAction {
  CartAction.add({required this.productId, this.quantity = 1})
      : type = CartActionType.add,
        itemId = null;
  CartAction.update({required this.itemId, required this.quantity})
      : type = CartActionType.update,
        productId = null;
  CartAction.remove({required this.itemId})
      : type = CartActionType.remove,
        productId = null,
        quantity = 0;

  final CartActionType type;
  final int? productId;
  final int? itemId;
  final int quantity;
}

/// For emulator vs desktop convenience, expose the base URL used
final apiBaseUrlProvider = Provider<String>((_) => apiBaseUrl);
