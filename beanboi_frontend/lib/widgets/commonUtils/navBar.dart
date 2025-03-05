import 'package:flutter/material.dart';

import '../beansDisplay/beanDisplay.dart';

class navBar extends StatelessWidget {
  Route _routeToBeans() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BeansDisplay(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInCirc;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cardNames = [
      {'name': 'Beans', 'route': _routeToBeans()},
      {'name': 'Bean Purchases', 'route': _routeToBeans()},
      {'name': 'Grinders', 'route': _routeToBeans()},
      {'name': 'Recipes', 'route': _routeToBeans()},
      {'name': 'Brews', 'route': _routeToBeans()},
      {'name': 'Stats', 'route': _routeToBeans()}
    ];

    int screenIndex = 0;
    void handleScreenChanged(int selectedScreen) {
      Navigator.of(context).push(cardNames[selectedScreen]["route"]);
    }

    return NavigationDrawer(
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
            selectedIcon: Icon(Icons.abc),
          );
        }),
        const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10), child: Divider()),
      ],
    );
  }
}
