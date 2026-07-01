import '../models/app_user.dart';
import 'api_client.dart';

class AuthResult {
  final String token;
  final AppUser user;

  AuthResult({required this.token, required this.user});
}

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<AuthResult> login(String email, String password) async {
    final res = await _apiClient.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Invalid login'));
    }

    final decoded = _apiClient.decode(res);
    _apiClient.token = decoded['token'];
    return AuthResult(token: decoded['token'], user: AppUser.fromJson(decoded['user']));
  }

  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    bool becomeSeller = false,
    String? shopName,
    String? bio,
  }) async {
    final res = await _apiClient.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
      'becomeSeller': becomeSeller,
      if (shopName != null) 'shopName': shopName,
      if (bio != null) 'bio': bio,
    });

    if (res.statusCode != 201) {
      throw Exception(_apiClient.errorMessage(res, 'Could not create account'));
    }

    final decoded = _apiClient.decode(res);
    _apiClient.token = decoded['token'];
    return AuthResult(token: decoded['token'], user: AppUser.fromJson(decoded['user']));
  }

  void logout() {
    _apiClient.token = null;
  }
}
