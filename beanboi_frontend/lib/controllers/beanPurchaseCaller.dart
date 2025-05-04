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

Future<void> updatePurchase (Map<String, dynamic> map, String UID, String id) async {
  String updateBeanUrl = "/users/"+UID+"/beanPurchases/"+id;
  await manager.sendPutWithBody(updateBeanUrl, map);
} 

Future<void> deletePurchase (String UID, String beanId, bool isArchive) async {
  String deleteBeanUrl = "/users/"+UID+"/beanPurchases/"+beanId;
  await manager.sendDeleteWithBody(deleteBeanUrl, isArchive);
}


