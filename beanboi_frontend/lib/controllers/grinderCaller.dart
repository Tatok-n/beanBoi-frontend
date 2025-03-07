import 'dart:convert';
import 'dart:math';

import 'httpManager.dart' as manager;

Future<List<Map<String,dynamic>>> getAllGrinders(String UID) async {
  String getAllGrindersURI = "/users/"+UID+"/grinders"; 
  List<dynamic> data = jsonDecode(await manager.sendGet(getAllGrindersURI));
  List<Map<String, dynamic>> fetchedGrinders = data.cast<Map<String, dynamic>>();
  return fetchedGrinders ;
}

Future<void> saveGrinder (Map<String, dynamic> map, String UID) async {
  String saveBeanURL = "/users/"+UID+"/grinders/";
  await manager.sendPutWithBody(saveBeanURL, map);
} 

Future<void> updateGrinder (Map<String, dynamic> map, String UID) async {
  String updateGrinderURI = "/users/"+UID+"/grinders/"+map["id"];
  await manager.sendPostWithBody(updateGrinderURI, map);
} 

Future<void> deleteGrinder(String UID, String grinderId) async {
  String deleteGrinderURI = "/users/"+UID+"/grinders/"+grinderId;
  await manager.sendDelete(deleteGrinderURI);
}
