import 'package:http/http.dart' as http;
import 'dart:convert';



String baseUrl = "http://localhost:8090";



Future<String> sendGet(String path) async {
    final response = await http.get(
        Uri.parse(baseUrl + path)
    );
    if (response.statusCode == 200) {
        return response.body;
    } else {
        return "Error ${response.statusCode}: ${response.body}";
    }
    }

Future<String> sendPostWithBody(String path, Object body) async {
  final response = await http.post(Uri.parse(baseUrl + path),
   headers: {'Content-Type': 'application/json'},
   body: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.body;
    } else {
        return "Error ${response.statusCode}: ${response.body}";
    }
}

Future<void> sendDelete(String path) async {
  final response = await http.delete(Uri.parse(baseUrl + path));
  if (response.statusCode != 200) {
    throw Exception("Failed to delete bean");
  }
}



