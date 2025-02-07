import 'dart:math';

import 'package:beanboi_frontend/widgets/displayUtils/label.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  DataCard(this.data, {super.key});

  final Map<dynamic, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: const Color.fromARGB(255, 36, 36, 36),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft, // Ensure alignment to the left
              child: Text(
                data["Name"],
                style: TextStyle(
                  color: const Color.fromARGB(255, 64, 147, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Label("Roaster", data["Roaster"].toString()),
                        Label("Altitude", data["altitude"].toString())
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Label("Price", data["price"].toString()),
                        Label("Roast Degree", data["roastDegree"].toString())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}