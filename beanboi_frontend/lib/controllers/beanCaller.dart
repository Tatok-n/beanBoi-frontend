import 'dart:convert';
import 'dart:math';

import 'httpManager.dart' as manager;

Future<List<Map<String,dynamic>>> getAllBeans(String UID) async {
  String getAllBeansURL = "/users/"+UID+"/beans"; 
  List<dynamic> data = jsonDecode(await manager.sendGet(getAllBeansURL));
  List<Map<String, dynamic>> fetchedBeans = data.cast<Map<String, dynamic>>();
  return fetchedBeans ;
}

Future<void> saveBean (Map<String, dynamic> map, String UID) async {
  String saveBeanURL = "/users/"+UID+"/beans/";
  await manager.sendPost(saveBeanURL, map);
} 


