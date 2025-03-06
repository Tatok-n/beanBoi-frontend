import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/navBar.dart';

class GrinderDisplay extends StatefulWidget {
  @override
  _GrinderState createState() => _GrinderState();
}

class _GrinderState extends State<GrinderDisplay> {
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Grinder'),
          ),
          drawer: navBar(),
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }

}

