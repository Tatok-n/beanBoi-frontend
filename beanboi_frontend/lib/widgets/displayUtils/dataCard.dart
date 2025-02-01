import 'package:flutter/material.dart';

class dataCard extends StatelessWidget  {
  String labelTopass = "";
  String valueTopass = "";
  String name = "";


  @override
  Widget build(BuildContext context) {
    
    dataLabel label = dataLabel();
    label.labelName = labelTopass;
    label.value = valueTopass;
    return Card(
      child : Padding( padding: EdgeInsets.all(16.0),
      child : Column(
        children: [
          Text(
             name,
             style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(children: [label])
        ],
      )),
    );
      }


}


class dataLabel extends StatelessWidget  {
  String labelName = "label";
  String value = "value";


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(labelName),
      ),Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value),
      )],
    );
  }


}