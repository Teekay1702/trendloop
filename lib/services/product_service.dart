import '../models/product.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient _apiClient;

  ProductService(this._apiClient);

  Future<List<Product>> getProducts({String query = '', String? category}) async {
    final res = await _apiClient.get('/products', queryParameters: {
      if (query.isNotEmpty) 'query': query,
      if (category != null && category != 'All') 'category': category,
    });

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not load products'));
    }

    final decoded = _apiClient.decode(res) as Map<String, dynamic>;
    return (decoded['products'] as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> getProductById(String id) async {
    final res = await _apiClient.get('/products/$id');

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not load product'));
    }

    return Product.fromJson(_apiClient.decode(res)['product']);
  }

  Future<Product> createProduct(Map<String, dynamic> payload) async {
    final res = await _apiClient.post('/products', payload);

    if (res.statusCode >= 400) {
      throw Exception(_apiClient.errorMessage(res, 'Could not create listing'));
    }

    return Product.fromJson(_apiClient.decode(res)['product']);
  }
}
