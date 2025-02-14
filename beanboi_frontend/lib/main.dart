import 'package:beanboi_frontend/widgets/beansDisplay/beanDisplay.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'controllers/beanCaller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Userprefs userprefs = Userprefs();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: userprefs.mainAccent),
        useMaterial3: true,
      ),
      home: BeansDisplay()
    );
  }
  
}




