import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


String baseUrl = "http://10.0.2.2:8090";

String getBaseUrl() {
  if (Platform.isAndroid) {
    return "http://10.0.2.2:8090";
  } else if (Platform.isWindows) {
    return "http://localhost:8090";
  } else {
    return "http://localhost:8090";
  }
}



Future<String> sendGet(String path) async {
    baseUrl = getBaseUrl();
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
  baseUrl = getBaseUrl();
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
  baseUrl = getBaseUrl();
  final response = await http.delete(Uri.parse(baseUrl + path));
  if (response.statusCode != 200) {
    throw Exception("Failed to delete bean");
  }
}



