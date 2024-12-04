class CartModel {
  final String productId;
  final int quantity;
  final double discount;
  final List<ProductVariant> variants;
  final Map<String, dynamic> productMeta;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.discount,
    required this.variants,
    required this.productMeta,
  });

  // Copy constructor to modify quantity, discount, etc.
  CartModel copyWith({
    int? quantity,
    double? discount,
    List<ProductVariant>? variants,
    Map<String, dynamic>? productMeta,
  }) {
    return CartModel(
      productId: productId,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      variants: variants ?? this.variants,
      productMeta: productMeta ?? this.productMeta,
    );
  }

  // JSON serialization and deserialization
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'discount': discount,
      'variants': variants.map((variant) => variant.toJson()).toList(),
      'productMeta': productMeta,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      quantity: json['quantity'],
      discount: json['discount'],
      variants: (json['variants'] as List)
          .map((variant) => ProductVariant.fromJson(variant))
          .toList(),
      productMeta: Map<String, dynamic>.from(json['productMeta']),
    );
  }
}

class ProductVariant {
  final String size;
  final double price;

  ProductVariant({
    required this.size,
    required this.price,
  });

  // JSON serialization and deserialization
  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'price': price,
    };
  }

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      size: json['size'],
      price: json['price'],
    );
  }
}
