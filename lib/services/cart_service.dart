import 'api_client.dart';

class CartService {
  final ApiClient _apiClient;

  CartService(this._apiClient);

  Future<void> addToCart(
    String productId, {
    String? size,
    int quantity = 1,
  }) async {
    final res = await _apiClient.post('/cart/items', {
      'productId': productId,
      'size': size,
      'quantity': quantity,
    });

    if (res.statusCode >= 400) {
      throw Exception(
        _apiClient.errorMessage(
          res,
          'Could not add item to cart. Sign in first.',
        ),
      );
    }
  }
}
