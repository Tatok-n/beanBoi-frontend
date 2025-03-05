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

    int screenIndex = 0;

      void handleScreenChanged(int selectedScreen) {
    Navigator.of(context).push(cardNames[selectedScreen]["route"]);
  }

    return Scaffold(
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
      drawer:  NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Header', style: Theme.of(context).textTheme.titleSmall),
          ),
          ...cardNames.map((Map destination) {
            return NavigationDrawerDestination(
              label: Text(destination['name']),
              icon: Icon(Icons.abc),
              selectedIcon:  Icon(Icons.abc),
            );
          }),
          const Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
        ],
      )
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