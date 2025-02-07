
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {  
  Label(this.name, this.value);
  Userprefs userprefs = Userprefs();
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
  
  labelValue({
    super.key,
    required this.value,
  });
  final Userprefs userprefs = Userprefs();
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.right,
      style: userprefs.smallText,
    );
  }
}

class labelText extends StatelessWidget {
  labelText({
    super.key,
    required this.name,
  });

  final Userprefs userprefs = Userprefs();

  final String name;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Text(
        name + ":",
        style : userprefs.smallHeading,
        textAlign: TextAlign.left,
      ),
    );
  }
}