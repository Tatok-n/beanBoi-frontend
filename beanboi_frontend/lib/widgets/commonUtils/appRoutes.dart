import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/beansDisplay/beanDisplay.dart';
import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/beanPurchaseDisplay.dart';
import 'package:beanboi_frontend/widgets/grinderDisplay/grinderDisplay.dart';
import 'package:beanboi_frontend/main.dart';

class appRoutes {
  static Route routeToHome() => _makeAnimatedRoute(MyApp());
  static Route routeToBeans() => _makeAnimatedRoute(BeansDisplay());
  static Route routeToPurchases() => _makeAnimatedRoute(BeanPurchaseDisplay());
  static Route routeToGrinders() => _makeAnimatedRoute(GrinderDisplay());

  static PageRouteBuilder<dynamic> _makeAnimatedRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInCirc;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
