import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com";

  /// ================= LOGIN =================
  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      return null;
    }
  }

  /// ================= GET PRODUCTS =================
  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal ambil produk');
    }
  }

  /// ================= DETAIL =================
  static Future<Map<String, dynamic>> getProductDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal ambil detail');
    }
  }

  /// ================= CREATE =================
  static Future<Map<String, dynamic>> createProduct() async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": "Produk Baru",
        "price": 100.0,
        "description": "Deskripsi produk",
        "category": "electronics",
        "image": "https://i.pravatar.cc",
      }),
    );

    return jsonDecode(response.body);
  }

  /// ================= UPDATE =================
  static Future<Map<String, dynamic>> updateProduct(int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": "Produk Update", "price": 150.0}),
    );

    return jsonDecode(response.body);
  }

  /// ================= DELETE =================
  static Future<void> deleteProduct(int id) async {
    await http.delete(Uri.parse('$baseUrl/products/$id'));
  }
}
