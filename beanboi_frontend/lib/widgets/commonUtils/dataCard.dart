import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/commonUtils/label.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/widgets/beansDisplay/utils/beanDialog.dart';
import 'package:beanboi_frontend/controllers/beanCaller.dart' as beanCaller;

class DataCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  late final Widget dialog;
  final String user;
  late List<Widget> children = [];

  DataCard(this.data, this.user, this.children,{super.key});

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
            title: Text(
              data["name"],
              style: userprefs.onPrimaryContainerSmallHeading,
            ),
            children: children,
          ),
        );

  }
}
