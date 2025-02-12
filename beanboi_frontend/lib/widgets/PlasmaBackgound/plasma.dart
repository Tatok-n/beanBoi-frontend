import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';

class Plasma extends StatelessWidget {
  Userprefs prefs = Userprefs();
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff000000),
            Color(0xff000000)
          ],
          stops: [
            0,
            0.3333333333333333,
            0.6666666666666666,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
    );
  }
}
