import 'package:flutter/material.dart';

class Userprefs {
  bool darkTheme = true;
  Color mainAccent = Color.fromARGB(255, 255, 181, 23);
  Color accent2 = Color.fromARGB(255, 255, 181, 23);
  Color accent3 = Color.fromARGB(255, 255, 181, 23);

  Color black1 = Color.fromARGB(255, 12, 12, 12);
  Color black2 = Color.fromARGB(255, 28, 28, 28);
  Color black3 = Color.fromARGB(255, 50, 50, 50);

  Color white1 = Color.fromARGB(255, 233, 233, 233);

  double bigFont = 24;
  double mediumFont = 18;
  double smallFont = 16;

  TextStyle get smallHeading => TextStyle(fontFamily: 'Roboto', fontSize: mediumFont, color: white1, fontWeight: FontWeight.bold);
  TextStyle get smallText => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: white1, fontWeight: FontWeight.w300);

  
}