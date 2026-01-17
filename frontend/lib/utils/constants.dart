class ApiConstants {
  // Change this to your backend URL
  // For local development: http://10.0.2.2:5000 (Android Emulator)
  // For local development: http://localhost:5000 (iOS Simulator/Web)
  // For production: your deployed backend URL
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  // Auth endpoints
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String getMe = '$baseUrl/auth/me';

  // Todo endpoints
  static const String todos = '$baseUrl/todos';
}
