import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    // defaultValue: 'https://trendloop-backend.onrender.com',
  );

  final http.Client _client;
  String? token;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  Uri uri(String path, {Map<String, String?> queryParameters = const {}}) {
    return Uri.parse('$baseUrl$path').replace(
      queryParameters: {
        for (final entry in queryParameters.entries)
          if (entry.value != null && entry.value!.isNotEmpty)
            entry.key: entry.value!,
      },
    );
  }

  Future<http.Response> get(
    String path, {
    Map<String, String?> queryParameters = const {},
  }) {
    return _client.get(
      uri(path, queryParameters: queryParameters),
      headers: headers,
    );
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) {
    return _client.post(uri(path), headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> patch(String path, Map<String, dynamic> body) {
    return _client.patch(uri(path), headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String path) {
    return _client.delete(uri(path), headers: headers);
  }

  dynamic decode(http.Response response) => jsonDecode(response.body);

  String errorMessage(http.Response response, String fallback) {
    try {
      return decode(response)['message'] ?? fallback;
    } catch (_) {
      return fallback;
    }
  }
}
