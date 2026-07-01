import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/product.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import '../services/product_service.dart';
import '../services/seller_service.dart';

class AppState extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();

  late final AuthService authService = AuthService(apiClient);
  late final ProductService productService = ProductService(apiClient);
  late final CartService cartService = CartService(apiClient);
  late final SellerService sellerService = SellerService(apiClient);
  late final OrderService orderService = OrderService(apiClient);

  final List<Product> products = [];
  final List<Product> cart = [];
  String selectedCategory = 'All';
  bool loading = false;
  String? error;
  AppUser? currentUser;

  bool get isLoggedIn => currentUser != null;
  bool get isSeller => currentUser?.isSeller ?? false;

  Future<void> loadProducts({String query = '', String? category}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final data = await productService.getProducts(
        query: query,
        category: category ?? selectedCategory,
      );
      products
        ..clear()
        ..addAll(data);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    final result = await authService.login(email, password);
    currentUser = result.user;
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    bool becomeSeller = false,
    String? shopName,
    String? bio,
  }) async {
    final result = await authService.register(
      name: name,
      email: email,
      password: password,
      becomeSeller: becomeSeller,
      shopName: shopName,
      bio: bio,
    );
    currentUser = result.user;
    notifyListeners();
  }

  Future<void> demoLogin() => login('mia@example.com', 'password123');

  void logout() {
    authService.logout();
    currentUser = null;
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    loadProducts(category: category);
  }

  Future<void> addToCart(Product product, {String? size}) async {
    cart.add(product);
    notifyListeners();
    try {
      if (!isLoggedIn) await demoLogin();
      await cartService.addToCart(product.id, size: size);
    } catch (_) {
      // Keep local cart for offline/demo friendliness.
    }
  }

  Future<Product> createProduct(Map<String, dynamic> payload) async {
    return productService.createProduct(payload);
  }

  double get cartSubtotal => cart.fold(0, (sum, item) => sum + item.price);
}
