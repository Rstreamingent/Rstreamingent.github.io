import 'dart:convert';
import 'package:http/http.dart' as http;

class NodeJsApi {
  final String baseUrl;

  NodeJsApi(this.baseUrl);

  Future<dynamic> fetchData(String path) async {
    final response = await http.get(Uri.parse('$baseUrl$path'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postData(String path, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
