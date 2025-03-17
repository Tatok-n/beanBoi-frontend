import 'dart:math';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';


class DataCardWithExtras extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  late final Widget dialog;
  final String user;
  late List<Widget> children = [];
  late Widget leading;

  DataCardWithExtras(this.data, this.user, this.children,this.leading,{super.key});

  final Userprefs userprefs = Userprefs();

  @override
  Widget build(BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: userprefs.colorScheme.surfaceContainerLow,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: userprefs.colorScheme.secondary, width: 2),
          ),
          child: ExpansionTile(
            leading: leading,
            title: Text(
              data["name"],
              style: userprefs.onPrimaryContainerSmallHeading,

            ),
            children: children,
          ),
        );

  }
}
