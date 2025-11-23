class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.isActive,
    this.description,
    this.imageUrl,
    this.categoryId,
  });

  final int id;
  final String name;
  final double price;
  final int stock;
  final bool isActive;
  final String? description;
  final String? imageUrl;
  final int? categoryId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: _asInt(json['id']),
        name: json['name'] as String? ?? '',
        price: _asDouble(json['price']),
        stock: _asInt(json['stock'] ?? 0),
        isActive: (json['isActive'] ?? json['is_active']) == 1 ||
            json['isActive'] == true ||
            json['is_active'] == true,
        description: json['description'] as String?,
        imageUrl: json['image_url'] as String? ?? json['imageUrl'] as String?,
        categoryId: json['category_id'] != null
            ? _asInt(json['category_id'])
            : null,
      );
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

double _asDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) {
    final parsed = double.tryParse(value);
    if (parsed != null) return parsed;
  }
  return 0;
}
