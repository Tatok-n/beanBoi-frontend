import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/commonUtils/dataCard.dart';
import 'package:beanboi_frontend/widgets/commonUtils/label.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/widgets/beansDisplay/utils/beanDialog.dart';
import 'package:beanboi_frontend/controllers/grinderCaller.dart' as grinderCaller;

import 'grinderDialog.dart';

class GrinderCard extends StatelessWidget {

  final Map<String, dynamic> data;
  late final GrinderDialog dialog;
  final String user;
  final Function() updateBeanCallback;

  GrinderCard(this.data, this.updateBeanCallback, this.user, {super.key}) {
    dialog = GrinderDialog(
      initialValues: data,
      buttonText: "Update",
    );
  }

  final Userprefs userprefs = Userprefs();

  @override
  Widget build(BuildContext context) {
    return DataCard(data, user, [
      _buildActionButtons(context),
      getContent(),
      
    ]);

  }



  Widget getContent() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < 500;
    return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: isSmallScreen ? _buildSingleColumnLayout() : _buildTwoColumnLayout(),
                ),
              );});
  }



  Widget _buildActionButtons(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildActionButton(Icons.edit, "Edit", () async {
              print(data);
              final result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (BuildContext context) => GrinderDialog(
                  initialValues: data,
                  buttonText: "Add",
                ),
              );

              if (result!=null) {
                print("Updating grinder");
                updateGrinder(result);       
              }
            },),
            _buildActionButton(Icons.delete, "Delete", () async {
              await deleteGrinder();
              updateBeanCallback();
            }),
          ],
        ),
      ),
    );
  }


  Widget _buildActionButton(IconData icon, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon), Text(text)],
        ),
      ),
    );
  }


  Widget _buildSingleColumnLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label("Number of settings", data["settings"].length.toString()),
      ],
    );
  }


  Widget _buildTwoColumnLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label("Settings", data["settings"].toString()),
      ],
    );
  }

  Future<void> deleteGrinder() async {
    try {
      await grinderCaller.deleteGrinder(user, data["id"]);
    } catch (e) {
      print("Error deleting grinder: $e");
    }
  }

  Future<void> updateGrinder(grinderToUpdate) async {
    try {
      Map<String, dynamic> updatedGrinder = {
        "name": grinderToUpdate["name"],
        "settings": grinderToUpdate["settings"],
        "id": data["id"],
        "uid": data["uid"],
        "isActive": data["isActive"]
      };
      await grinderCaller.updateGrinder(updatedGrinder, user);
    } catch (e) {
      print("Error updating grinder: $e");
    }
  }
  
}