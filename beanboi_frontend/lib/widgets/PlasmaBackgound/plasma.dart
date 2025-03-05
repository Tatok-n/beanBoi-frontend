import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:simple_animations/simple_animations.dart';

class PlasmaBg extends StatelessWidget {
  Userprefs userprefs = Userprefs();
  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      tileMode: TileMode.mirror,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff362000),
        Color(0xff0b0700),
      ],
      stops: [
        0,
        1,
      ],
    ),
    backgroundBlendMode: BlendMode.srcOver,
  ),
  child: PlasmaRenderer(
    type: PlasmaType.infinity,
    particles: 10,
    color: userprefs.colorScheme.secondary,
    blur: 1,
    size: 0.45,
    speed: 1,
    offset: 0,
    blendMode: BlendMode.plus,
    particleType: ParticleType.atlas,
    variation1: 0,
    variation2: 0,
    variation3: 0,
    rotation: 0,
  ),
);
  }
}
