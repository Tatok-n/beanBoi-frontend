import 'dart:convert';
import 'dart:math';

import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'httpManager.dart' as manager;

Future<List<Map<String,dynamic>>> getAllBeans(String UID) async {
  final prefs = await SharedPreferences.getInstance();
  String getAllBeansURL = "/users/"+UID+"/beans"; 
  String jsonValues = await manager.sendGet(getAllBeansURL);
  List<dynamic> data = jsonDecode(jsonValues);
  List<Map<String, dynamic>> fetchedBeans = data.cast<Map<String, dynamic>>();
  await prefs.setString('beans', jsonValues);
  return fetchedBeans;
}

Future<void> saveBean (Map<String, dynamic> map, String UID) async {
  String saveBeanURL = "/users/"+UID+"/beans/";
  await manager.sendPostWithBody(saveBeanURL, map);
} 

Future<void> updateBean (Map<String, dynamic> map, String UID) async {
  String updateBeanUrl = "/users/"+UID+"/beans/"+map["id"];
  await manager.sendPostWithBody(updateBeanUrl, map);
} 

Future<void> deleteBean(String UID, String beanId) async {
  String deleteBeanUrl = "/users/"+UID+"/beans/"+beanId;
  await manager.sendDelete(deleteBeanUrl);
}


