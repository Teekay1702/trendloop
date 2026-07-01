import 'seller.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final Seller? seller;
  final bool emailVerified;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.seller,
    this.emailVerified = false,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    avatarUrl: json['avatarUrl'],
    seller: json['seller'] == null ? null : Seller.fromJson(json['seller']),
    emailVerified: json['emailVerified'] ?? json['emailVerifiedAt'] != null,
  );

  bool get isSeller => seller != null;
}
