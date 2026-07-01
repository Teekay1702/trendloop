import 'product.dart';
import 'seller.dart';

class StoreSummary {
  final Seller seller;
  final int productCount;
  final List<Product> previewProducts;

  StoreSummary({
    required this.seller,
    required this.productCount,
    required this.previewProducts,
  });

  factory StoreSummary.fromJson(Map<String, dynamic> json) {
    return StoreSummary(
      seller: Seller.fromJson(json),
      productCount: json['productCount'] ?? 0,
      previewProducts: (json['previewProducts'] as List? ?? const [])
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}
