import 'package:flutter/material.dart';

class Userprefs {
  Color mainAccent = Color.fromARGB(255, 255, 174, 0);
  bool isDark = true;

  late ColorScheme colorScheme;

  double baseFontSize = 16;

  double get bigFont => baseFontSize * 1.5;
  double get mediumFont => baseFontSize * 1.125;
  double get smallFont => baseFontSize;


  TextStyle get onPrimaryContainerTextM => TextStyle(fontFamily: 'Roboto', fontSize: mediumFont, color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400);
  TextStyle get inverseSurfaceTextS => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: colorScheme.inverseSurface, fontWeight: FontWeight.w100);
  TextStyle get onPrimaryContainerSmallHeading => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold);
  

  TextStyle get smallInputTextSurface => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: colorScheme.onSurface, fontWeight: FontWeight.w100);
  TextStyle get smallInputLabelSurface => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w300);
  TextStyle get smallInputHintSurface => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w100);


  TextStyle get smallHeading => TextStyle(fontFamily: 'Roboto', fontSize: mediumFont, color: colorScheme.onSecondary, fontWeight: FontWeight.bold);
  TextStyle get smallText => TextStyle(fontFamily: 'Roboto', fontSize: smallFont, color: colorScheme.onSecondary, fontWeight: FontWeight.w300);
  


  Userprefs() {
    colorScheme = generateColorScheme(mainAccent, isDark);
  }

  ColorScheme generateColorScheme(Color baseColor, bool isDark) {
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    return ColorScheme.fromSeed(seedColor: mainAccent, brightness: brightness);
  }
  
  
}