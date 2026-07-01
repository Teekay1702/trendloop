import 'seller.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String category;
  final String condition;
  final double price;
  final double? originalPrice;
  final String currency;
  final List<String> images;
  final List<String> sizes;
  final String color;
  final int stock;
  final double rating;
  final int reviewCount;
  final double shippingPrice;
  final Seller? seller;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.condition,
    required this.price,
    required this.originalPrice,
    required this.currency,
    required this.images,
    required this.sizes,
    required this.color,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.shippingPrice,
    required this.seller,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        condition: json['condition'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        originalPrice: json['originalPrice'] == null ? null : (json['originalPrice']).toDouble(),
        currency: json['currency'] ?? 'USD',
        images: List<String>.from(json['images'] ?? const []),
        sizes: List<String>.from(json['sizes'] ?? const ['One size']),
        color: json['color'] ?? '',
        stock: json['stock'] ?? 0,
        rating: (json['rating'] ?? 0).toDouble(),
        reviewCount: json['reviewCount'] ?? 0,
        shippingPrice: (json['shippingPrice'] ?? 0).toDouble(),
        seller: json['seller'] == null ? null : Seller.fromJson(json['seller']),
      );
}
