
import 'package:flutter/material.dart';

class Label extends StatelessWidget {  
  Label(this.name, this.value);

  final String name;
  final String value;

  
Widget build(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Row(
      children: [
        labelText(name: name),
        Expanded(
          child: labelValue(value: value),
        ),
      ],
    ),
  );
}

}

class labelValue extends StatelessWidget {
  const labelValue({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.right,
      style: TextStyle(color : Colors.white70, fontSize: 10),
    );
  }
}

class labelText extends StatelessWidget {
  const labelText({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        name + ":",
        style : TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}