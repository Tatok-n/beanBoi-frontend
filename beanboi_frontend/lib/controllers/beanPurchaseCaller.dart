import 'dart:convert';
import 'dart:math';

import 'httpManager.dart' as manager;

Future<List<Map<String,dynamic>>> getAllPurchases(String UID) async {
  String getAllBeansURL = "/users/"+UID+"/beanPurchases"; 
  List<dynamic> data = jsonDecode(await manager.sendGet(getAllBeansURL));
  List<Map<String, dynamic>> fetchedBeans = data.cast<Map<String, dynamic>>();
  return fetchedBeans ;
}

Future<void> savePurchase (Map<String, dynamic> map, String UID) async {
  String saveBeanURL = "/users/"+UID+"/beanPurchases";
  await manager.sendPostWithBody(saveBeanURL, map);
} 

Future<void> updatePurchase (Map<String, dynamic> map, String UID) async {
  String updateBeanUrl = "/users/"+UID+"/beanPurchases/"+map["id"];
  await manager.sendPostWithBody(updateBeanUrl, map);
} 

Future<void> deletePurchase (String UID, String beanId) async {
  String deleteBeanUrl = "/users/"+UID+"/beanPurchases/"+beanId;
  await manager.sendDelete(deleteBeanUrl);
}


