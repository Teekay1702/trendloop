import '../models/app_user.dart';
import 'api_client.dart';

class AuthResult {
  final String token;
  final AppUser user;
  final String? message;

  AuthResult({required this.token, required this.user, this.message});
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
    return AuthResult(
      token: decoded['token'],
      user: AppUser.fromJson(decoded['user']),
      message: decoded['message'],
    );
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
    return AuthResult(
      token: decoded['token'],
      user: AppUser.fromJson(decoded['user']),
      message: decoded['message'],
    );
  }

  Future<AuthResult> verifyEmail(String code) async {
    final res = await _apiClient.post('/auth/email/verify', {'code': code});

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not verify email'));
    }

    final decoded = _apiClient.decode(res);
    _apiClient.token = decoded['token'];
    return AuthResult(
      token: decoded['token'],
      user: AppUser.fromJson(decoded['user']),
      message: decoded['message'],
    );
  }

  Future<String> resendVerificationEmail() async {
    final res = await _apiClient.post('/auth/email/resend-verification', {});

    if (res.statusCode != 200) {
      throw Exception(
        _apiClient.errorMessage(res, 'Could not send verification email'),
      );
    }

    return _apiClient.decode(res)['message'] ?? 'Verification email sent';
  }

  Future<String> forgotPassword(String email) async {
    final res = await _apiClient.post('/auth/password/forgot', {
      'email': email,
    });

    if (res.statusCode != 200) {
      throw Exception(
        _apiClient.errorMessage(res, 'Could not request password reset'),
      );
    }

    return _apiClient.decode(res)['message'] ??
        'If that email exists, a password reset link has been sent';
  }

  Future<AuthResult> resetPassword({
    required String token,
    required String password,
  }) async {
    final res = await _apiClient.post('/auth/password/reset', {
      'token': token,
      'password': password,
    });

    if (res.statusCode != 200) {
      throw Exception(_apiClient.errorMessage(res, 'Could not reset password'));
    }

    final decoded = _apiClient.decode(res);
    _apiClient.token = decoded['token'];
    return AuthResult(
      token: decoded['token'],
      user: AppUser.fromJson(decoded['user']),
      message: decoded['message'],
    );
  }

  void logout() {
    _apiClient.token = null;
  }
}
