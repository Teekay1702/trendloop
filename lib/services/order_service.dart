import 'api_client.dart';

class OrderService {
  final ApiClient _apiClient;

  OrderService(this._apiClient);

  Future<Map<String, dynamic>> createOrder({
    Map<String, dynamic>? shippingAddress,
  }) async {
    final res = await _apiClient.post('/orders', {
      if (shippingAddress != null) 'shippingAddress': shippingAddress,
    });

    if (res.statusCode != 201) {
      throw Exception(_apiClient.errorMessage(res, 'Could not create order'));
    }

    return _apiClient.decode(res)['order'];
  }

  Future<List<dynamic>> getOrders() async {
    final res = await _apiClient.get('/orders');

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not load orders'));
    }

    return _apiClient.decode(res)['orders'] as List<dynamic>;
  }
}
