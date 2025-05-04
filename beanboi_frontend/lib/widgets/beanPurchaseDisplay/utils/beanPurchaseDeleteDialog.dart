import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDropdown.dart';
import 'package:beanboi_frontend/widgets/commonUtils/datePicker.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/controllers/beanPurchaseCaller.dart'
    as beanPurchaseCaller;

import '../../commonUtils/appRoutes.dart';

class BeanPurchaseDeletedialog extends StatefulWidget {
  String beanId;
  String uid;

  BeanPurchaseDeletedialog({
    required this.beanId,
    required this.uid,
  });

  @override
  State<BeanPurchaseDeletedialog> createState() =>
      _BeanPurchaseDeletedialogState();
}

class _BeanPurchaseDeletedialogState extends State<BeanPurchaseDeletedialog> {
  Set<String>? selectedOption = {"archive"};
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final prefs = Userprefs();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You are about to delete this purchase, \nyou can either archive it, in such a way that statistics are not affected, or delete it completely.",
            style: TextStyle(
              color: prefs.colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SegmentedButton(
                  segments: const [
                    ButtonSegment(
                      value: "archive",
                      label: Text("Archive"),
                    ),
                    ButtonSegment(
                      value: "delete",
                      label: Text("Delete"),
                    ),
                  ],
                  selected: selectedOption!,
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      selectedOption = newSelection;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    beanPurchaseCaller.deletePurchase(
                        widget.beanId, widget.uid, (selectedOption!.first == "delete" ? true : false));
                    Navigator.of(context).pop();
                  },
                  child: Text("Confirm"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
