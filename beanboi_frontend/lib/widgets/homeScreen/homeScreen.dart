import 'package:beanboi_frontend/widgets/beansDisplay/beanDisplay.dart';
import 'package:beanboi_frontend/widgets/commonUtils/navBar.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';

class HomeScreen extends StatelessWidget {
  Userprefs prefs = Userprefs();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to BeanBoi!'),
          
          ],
        ),
      ),
      drawer:  navBar(),
    );
  }
}

