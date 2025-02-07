import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/displayUtils/label.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';

class DataCard extends StatelessWidget {
  DataCard(this.data, {super.key});

  final Map<dynamic, dynamic> data;
  final Userprefs userprefs = Userprefs();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
                  color: const Color.fromARGB(125, 43, 43, 43),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Color.fromARGB(0, 0, 0, 0))
                ),
          child: ExpansionTile(
            title: Text(data["Name"],style: TextStyle(color: userprefs.accent2,fontSize: userprefs.mediumFont,fontWeight: FontWeight.bold,),),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Container(
                decoration: BoxDecoration(
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
                                Label("Roaster", data["Roaster"].toString()),
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
                                Label("Price", data["price"].toString()),
                                Label("Roast Degree", data["roastDegree"].toString())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Label("Tasting notes", data["tastingNotes"].toString())
                    )
                  ],
                ),
                      ),
              )],
          ),
        ),
      ),
    );
  }
}