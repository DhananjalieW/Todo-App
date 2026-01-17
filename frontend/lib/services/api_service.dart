class ApiService {
  // For Android Emulator, use 10.0.2.2 instead of localhost
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Map<String, String> headersWithAuth(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
