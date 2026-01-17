import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';
import 'api_service.dart';

class TodoService {
  static Future<List<Todo>> getTodos(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/todos'),
        headers: ApiService.headersWithAuth(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          final List<dynamic> todosJson = data['data'];
          return todosJson.map((json) => Todo.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching todos: $e');
    }
  }

  static Future<Todo?> createTodo(
      String token, String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/todos'),
        headers: ApiService.headersWithAuth(token),
        body: jsonEncode({
          'title': title,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return Todo.fromJson(data['data']);
        }
      }

      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Failed to create todo');
    } catch (e) {
      throw Exception('Error creating todo: $e');
    }
  }

  static Future<Todo?> updateTodo(String token, String id,
      {String? title, String? description, bool? isCompleted}) async {
    try {
      final Map<String, dynamic> body = {};
      if (title != null) body['title'] = title;
      if (description != null) body['description'] = description;
      if (isCompleted != null) body['isCompleted'] = isCompleted;

      final response = await http.put(
        Uri.parse('${ApiService.baseUrl}/todos/$id'),
        headers: ApiService.headersWithAuth(token),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return Todo.fromJson(data['data']);
        }
      }

      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Failed to update todo');
    } catch (e) {
      throw Exception('Error updating todo: $e');
    }
  }

  static Future<void> toggleTodo(String token, String id) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiService.baseUrl}/todos/$id/toggle'),
        headers: ApiService.headersWithAuth(token),
      );

      if (response.statusCode != 200) {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Failed to toggle todo');
      }
    } catch (e) {
      throw Exception('Error toggling todo: $e');
    }
  }

  static Future<void> deleteTodo(String token, String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiService.baseUrl}/todos/$id'),
        headers: ApiService.headersWithAuth(token),
      );

      if (response.statusCode != 200) {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Failed to delete todo');
      }
    } catch (e) {
      throw Exception('Error deleting todo: $e');
    }
  }
}
