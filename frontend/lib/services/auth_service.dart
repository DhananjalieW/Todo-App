import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  User? _currentUser;
  String? _token;
  bool _isAuthenticated = false;
  String _errorMessage = '';
  bool _isLoading = false;

  // Getters
  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // Initialize service - check for existing token
  Future<void> init() async {
    _isLoading = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');

      if (_token != null) {
        final user = await getCurrentUser();
        if (user != null) {
          _currentUser = user;
          _isAuthenticated = true;
        } else {
          await logout();
        }
      }
    } catch (e) {
      _errorMessage = 'Error initializing auth: $e';
      await logout();
    }
    _isLoading = false;
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/auth/register'),
        headers: ApiService.headers,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success']) {
        _token = data['data']['token'];
        _currentUser = User(
          id: data['data']['id'],
          name: data['data']['name'],
          email: data['data']['email'],
        );
        _isAuthenticated = true;
        await _saveToken(_token!);
        _isLoading = false;
        return true;
      } else {
        _errorMessage = data['message'] ?? 'Registration failed';
        _isLoading = false;
        return false;
      }
    } catch (e) {
      _errorMessage = 'Connection error: $e';
      _isLoading = false;
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/auth/login'),
        headers: ApiService.headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        _token = data['data']['token'];
        _currentUser = User(
          id: data['data']['id'],
          name: data['data']['name'],
          email: data['data']['email'],
        );
        _isAuthenticated = true;
        await _saveToken(_token!);
        _isLoading = false;
        return true;
      } else {
        _errorMessage = data['message'] ?? 'Login failed';
        _isLoading = false;
        return false;
      }
    } catch (e) {
      _errorMessage = 'Connection error: $e';
      _isLoading = false;
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      if (_token == null) return null;

      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/auth/me'),
        headers: ApiService.headersWithAuth(_token!),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return User(
            id: data['data']['id'],
            name: data['data']['name'],
            email: data['data']['email'],
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _isAuthenticated = false;
    _errorMessage = '';

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    if (_token != null) return _token;

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    return _token;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
