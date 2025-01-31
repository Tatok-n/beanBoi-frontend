import 'package:http/http.dart' as http;
import 'dart:convert';



String baseUrl = "http://localhost:8080";



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



