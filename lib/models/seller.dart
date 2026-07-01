class Seller {
  final String id;
  final String shopName;
  final String bio;
  final double rating;
  final int followers;
  final int sales;
  final bool verified;

  Seller({
    required this.id,
    required this.shopName,
    required this.bio,
    required this.rating,
    required this.followers,
    required this.sales,
    required this.verified,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json['id'] ?? '',
        shopName: json['shopName'] ?? 'Seller',
        bio: json['bio'] ?? '',
        rating: (json['rating'] ?? 0).toDouble(),
        followers: json['followers'] ?? 0,
        sales: json['sales'] ?? 0,
        verified: json['verified'] ?? false,
      );
}
