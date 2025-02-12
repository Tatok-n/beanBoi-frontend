import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/displayUtils/label.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';
import 'package:beanboi_frontend/widgets/displayUtils/beanDialog.dart';
import 'package:beanboi_frontend/controllers/beanCaller.dart' as beanCaller;

class DataCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  late final Beandialog dialog;
  final String user;

  DataCard(this.data, this.updateBeanCallback, this.user, {super.key}) {
    dialog = Beandialog(
      initialValues: data,
      buttonText: "Save",
      saveFunction: updateBeanCallback,
    );
  }
  final Function() updateBeanCallback;


  final Userprefs userprefs = Userprefs();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(125, 43, 43, 43),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: userprefs.mainAccent, width: 2)),
      child: ExpansionTile(
        title: Text(
          data["name"],
          style: TextStyle(
            color: userprefs.mainAccent,
            fontSize: userprefs.mediumFont,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => dialog,
                  );
                  updateBeans(dialog.mapToEdit);
                  updateBeanCallback();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.edit), Text("Edit")],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Label("Roaster", data["roaster"].toString()),
                              Label("Altitude", data["altitude"].toString())
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Label("Origin", data["origin"].toString()),
                              Label("Process", data["process"].toString())
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Label("Price", data["price"].toString()),
                              Label("Roast Degree", data["roastDegree"].toString())
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      child: Label("Tasting notes", data["tastingNotes"].toString()))
                ],
              ),
            ),
          )
        ],
      ),
    );
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
        "id" : data["id"],
        "uid" : data["uid"],
        "isActive" : data["isActive"]
      };
      await beanCaller.updateBean(updatedBeans, user);
    } catch (e) {
      print("Error updatingBeans beans: $e");
    }
  }
}