import 'package:beanboi_frontend/main.dart';
import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/beanPurchaseDisplay.dart';
import 'package:beanboi_frontend/widgets/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

import '../beansDisplay/beanDisplay.dart';
import '../grinderDisplay/grinderDisplay.dart';
import 'appRoutes.dart';


class navBar extends StatelessWidget {
  Route _routeToHome() {
     return makeAnimatedRoute(MyApp());
  }


  Route _routeToBeans() {
    return makeAnimatedRoute(BeansDisplay());
  }

  Route _routeToPurchases() {
    return makeAnimatedRoute(BeanPurchaseDisplay());
  }

    Route _routeToGrinders() {
    return makeAnimatedRoute(GrinderDisplay());
  }


  PageRouteBuilder<dynamic> makeAnimatedRoute(Widget destination) {
     return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
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
  {'name': 'Beans', 'route': appRoutes.routeToBeans()},
  {'name': 'Bean Purchases', 'route': appRoutes.routeToPurchases()},
  {'name': 'Grinders', 'route': appRoutes.routeToGrinders()},
  {'name': 'Recipes', 'route': appRoutes.routeToBeans()},
  {'name': 'Brews', 'route': appRoutes.routeToBeans()},
  {'name': 'Stats', 'route': appRoutes.routeToBeans()},
  {'name': 'Settings', 'route': appRoutes.routeToBeans()},
  {'name': 'Home', 'route': appRoutes.routeToHome()},
];

    int screenIndex = 0;
    void handleScreenChanged(int selectedScreen) {
      screenIndex = selectedScreen;
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
