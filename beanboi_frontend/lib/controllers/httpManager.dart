import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


bool isAndroid = false;

String baseUrl = isAndroid  ? "http://10.0.2.2:8090" : "http://localhost:8090";

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

Future<String> sendPutWithBody(String path, Object body) async {
  final response = await http.put(Uri.parse(baseUrl + path),
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


Future<String> sendDeleteWithBody(String path, Object body) async {
  final response = await http.delete(Uri.parse(baseUrl + path),
   headers: {'Content-Type': 'application/json'},
   body: jsonEncode(body));
      if (response.statusCode == 200) {
        return "";
    } else {
        return "Error ${response.statusCode}: ${response.body}";
    }
}


