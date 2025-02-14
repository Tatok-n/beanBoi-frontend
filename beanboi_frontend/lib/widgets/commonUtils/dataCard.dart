import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/commonUtils/label.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/widgets/beansDisplay/utils/beanDialog.dart';
import 'package:beanboi_frontend/controllers/beanCaller.dart' as beanCaller;

class DataCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  late final Beandialog dialog;
  final String user;
  final Function() updateBeanCallback;
  late List<Widget> children = [];

  DataCard(this.data, this.updateBeanCallback, this.user, this.children, {super.key}) {
    dialog = Beandialog(
      initialValues: data,
      buttonText: "Update",
    );
  }

  final Userprefs userprefs = Userprefs();

  @override
  Widget build(BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: userprefs.colorScheme.surfaceContainerLow,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: userprefs.colorScheme.secondary, width: 2),
          ),
          child: ExpansionTile(
            title: Text(
              data["name"],
              style: userprefs.onPrimaryContainerSmallHeading,
            ),
            children: children,
          ),
        );

  }


  Widget _buildActionButtons(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildActionButton(Icons.edit, "Edit", () async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) => dialog,
              );
              if (dialog.formComplete) {
                updateBeans(dialog.mapToEdit);
                dialog.formComplete = false;
                updateBeanCallback();
              }
            }),
            _buildActionButton(Icons.delete, "Delete", () async {
              await deleteBean();
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
        Label("Roaster", data["roaster"].toString()),
        Label("Origin", data["origin"].toString()),
        Label("Altitude", data["altitude"].toString()),
        Label("Price", data["price"].toString()),
        Label("Roast Degree", data["roastDegree"].toString()),
        Label("Process", data["process"].toString()),
        Label("Tasting Notes", data["tastingNotes"].toString()),
      ],
    );
  }


  Widget _buildTwoColumnLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label("Roaster", data["roaster"].toString()),
                    Label("Origin", data["origin"].toString()),
                    Label("Altitude", data["altitude"].toString()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label("Price", data["price"].toString()),
                    Label("Roast Degree", data["roastDegree"].toString()),
                    Label("Process", data["process"].toString()),
                  ],
                ),
              ),
            ),
        
          ],
        ),
        Label("Tasting Notes", data["tastingNotes"].toString()),],
      
    );
  }

  Future<void> deleteBean() async {
    try {
      await beanCaller.deleteBean(user, data["id"]);
    } catch (e) {
      print("Error deleting bean: $e");
    }
  }

  Future<void> updateBeans(beanToUpdate) async {
    try {
      Map<String, dynamic> updatedBeans = {
        "name": beanToUpdate["name"],
        "origin": beanToUpdate["origin"],
        "process": beanToUpdate["process"],
        "price": beanToUpdate["price"],
        "roastDegree": beanToUpdate["roastDegree"],
        "roaster": beanToUpdate["roaster"],
        "altitude": beanToUpdate["altitude"],
        "tastingNotes": beanToUpdate["tastingNotes"],
        "id": data["id"],
        "uid": data["uid"],
        "isActive": data["isActive"]
      };
      await beanCaller.updateBean(updatedBeans, user);
    } catch (e) {
      print("Error updating bean: $e");
    }
  }
}
