import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../models/product.dart';
import '../models/cart_models.dart';

class ShopApi {
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await ApiClient.http.get('/products');
      final data = response.data as List<dynamic>;
      final list = data
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .where((p) => p.isActive)
          .toList();
      if (list.isEmpty) {
        return _fallbackProducts;
      }
      return list;
    } catch (_) {
      return _fallbackProducts;
    }
  }

  static Future<CartModel> fetchCart() async {
    final response = await ApiClient.http.get('/users/$apiUserId/cart');
    return CartModel.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<CartModel> addToCart(int productId, {int quantity = 1}) async {
    final res =
        await ApiClient.http.post('/users/$apiUserId/cart/items', data: {
      'productId': productId,
      'quantity': quantity,
    });
    // backend returns refreshed cart
    return CartModel.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<CartModel> updateCartItem(int itemId, int quantity) async {
    final res = await ApiClient.http.patch(
      '/users/$apiUserId/cart/items/$itemId',
      data: {'quantity': quantity},
    );
    return CartModel.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<CartModel> removeCartItem(int itemId) async {
    await ApiClient.http.delete('/users/$apiUserId/cart/items/$itemId');
    return fetchCart();
  }
}

final _fallbackProducts = <Product>[
  Product(
    id: 1,
    name: 'Sample Whey Protein',
    price: 199.0,
    stock: 10,
    isActive: true,
    description: 'High quality whey protein.',
    imageUrl: null,
    categoryId: 0,
  ),
  Product(
    id: 2,
    name: 'Resistance Bands',
    price: 99.0,
    stock: 20,
    isActive: true,
    description: 'Set of 5 bands.',
    imageUrl: null,
    categoryId: 0,
  ),
];
