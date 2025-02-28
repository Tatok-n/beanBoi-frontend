import 'package:beanboi_frontend/widgets/beansDisplay/beanDisplay.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';

class HomeScreen extends StatelessWidget {
  Userprefs prefs = Userprefs();
  List<Map<String, dynamic>> cardNames = [{'name' : 'Beans', 'route' : _routeToBeans()},
  {'name' : 'Bean Purchases', 'route' : _routeToBeans()},
  {'name' : 'Grinders', 'route' : _routeToBeans()},
  {'name' : 'Recipes', 'route' : _routeToBeans()},
  {'name' : 'Brews', 'route' : _routeToBeans()},
  {'name' : 'Stats', 'route' : _routeToBeans()}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          children: 
            cardNames.map((card) => Container(
              padding: const EdgeInsets.all(4), 
              child: SizedBox(
                height: 100,
                child: Card(
                  color: prefs.colorScheme.primaryContainer,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(card["route"]);
                        },
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20), 
                        ),
                        child: Text(card["name"], style: prefs.BigboiTextOnPrimaryContainer, textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              ),
            )).toList()
        ),
      ),
    );
  }
}

Route _routeToBeans() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => BeansDisplay(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}