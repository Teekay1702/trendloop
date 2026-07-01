import '../models/product.dart';
import '../models/seller.dart';
import '../models/store_summary.dart';
import 'api_client.dart';

class SellerStoreData {
  final Seller seller;
  final List<Product> products;

  SellerStoreData({required this.seller, required this.products});

  factory SellerStoreData.fromJson(Map<String, dynamic> json) {
    return SellerStoreData(
      seller: Seller.fromJson(json['seller']),
      products: (json['products'] as List? ?? const [])
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}

class SellerService {
  final ApiClient _apiClient;

  SellerService(this._apiClient);

  Future<List<StoreSummary>> getStores() async {
    final res = await _apiClient.get('/sellers');

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not load stores'));
    }

    return (_apiClient.decode(res)['sellers'] as List)
        .map((item) => StoreSummary.fromJson(item))
        .toList();
  }

  Future<Map<String, dynamic>> createSeller({
    required String shopName,
    String bio = '',
  }) async {
    final res = await _apiClient.post('/sellers', {
      'shopName': shopName,
      'bio': bio,
    });

    if (res.statusCode != 201) {
      throw Exception(
        _apiClient.errorMessage(res, 'Could not create seller profile'),
      );
    }

    return _apiClient.decode(res)['seller'];
  }

  Future<SellerStoreData> getMyStore() async {
    final res = await _apiClient.get('/sellers/me');

    if (res.statusCode != 200) {
      throw Exception(
        _apiClient.errorMessage(res, 'Could not load your seller store'),
      );
    }

    return SellerStoreData.fromJson(_apiClient.decode(res));
  }

  Future<SellerStoreData> getSellerById(String id) async {
    final res = await _apiClient.get('/sellers/$id');

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not load seller'));
    }

    return SellerStoreData.fromJson(_apiClient.decode(res));
  }
}
