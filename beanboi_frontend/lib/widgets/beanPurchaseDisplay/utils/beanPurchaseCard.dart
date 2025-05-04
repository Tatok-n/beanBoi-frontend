import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDeleteDialog.dart';
import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDialog.dart';
import 'package:beanboi_frontend/widgets/commonUtils/dataCardWithExtras.dart';
import 'package:beanboi_frontend/widgets/commonUtils/label.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/widgets/beansDisplay/utils/beanDialog.dart';
import 'package:beanboi_frontend/controllers/beanPurchaseCaller.dart' as beanPurchaseCaller;

class BeanPurchaseCard extends StatelessWidget {

  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> beans;
  late final BeanPurchaseDialog dialog;
  final String user;
  final Function() updatePurchaseCallback;
  

  BeanPurchaseCard(this.data, this.updatePurchaseCallback, this.user, {required this.beans , super.key}) {
    dialog = BeanPurchaseDialog(
      isUpdate: true,
      beans: this.beans,
      initialValues: {
        "id": data["id"],
        "isActive": data["isActive"],
        "name": data["name"],
        "beanId": data["beans"]["id"],
        "pricePaid": data["pricePaid"],
        "amountPurchased": data["amountPurchased"],
        "amountRemaining": data["amountRemaining"],
        "dateOfPurchase": DateTime.parse(data["purchaseDate"]),
        "dateOfRoast": DateTime.parse(data["roastDate"]),
      },
      buttonText: "Update",
    );
  }

  
  late BeanPurchaseDeletedialog deleteDialog;
  final Userprefs userprefs = Userprefs();



  @override
  Widget build(BuildContext context) {
    deleteDialog = BeanPurchaseDeletedialog(
    beanId: data["id"],
    uid: user,
  );
    return DataCardWithExtras(data, user, [
      _buildActionButtons(context),
      getContent(),
    ],AmountProgressBarHorizontal(data));

  }

    Widget AmountProgressBarHorizontal(Map<String, dynamic> data) {
    double amountPurchased = double.parse(data["amountPurchased"]);
    double ratioLeft = double.parse(data["amountRemaining"]) /amountPurchased;
    return  Container(
                width: min(200, max(50,amountPurchased)),
                height: 20,
                decoration: BoxDecoration(
                  color: userprefs.colorScheme.surfaceDim,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: LinearProgressIndicator(
                    value: ratioLeft,
                    valueColor: AlwaysStoppedAnimation<Color>(userprefs.colorScheme.secondary),
                  ),
                ),);
  }






  Widget getContent() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < 500;
    return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: isSmallScreen ? _buildSingleColumnLayout() : _buildTwoColumnLayout(),
                ),
              );});
  }



  Widget _buildActionButtons(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildActionButton(Icons.edit, "Edit", () async {
              final result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (BuildContext context) => dialog,
              );
             if (result != null) {
                updatePurchase(result);
                updatePurchaseCallback();
              }
            }),
            _buildActionButton(Icons.delete, "Delete", () async {
              await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (BuildContext context) => deleteDialog,
              );
              updatePurchaseCallback();
            }),
          ],
        ),
      ),
    );
  }


  Widget _buildActionButton(IconData icon, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon), Text(text)],
        ),
      ),
    );
  }


  Widget _buildSingleColumnLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label("Name", data["name"].toString()),
        Label("Amount purchased", data["amountPurchased"].toString()),
        Label("Amount remaining", data["amountRemaining"].toString()),
        Label("Purchase date", data["purchaseDate"].toString()),
        Label("Roast date", data["roastDate"].toString()),
      ],
    );
  }


  Widget _buildTwoColumnLayout() {
    return
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label("Amount purchased", data["amountPurchased"].toString()),
        Label("Amount remaining", data["amountRemaining"].toString()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
        Label("Purchase date", data["purchaseDate"].toString()),
        Label("Roast date", data["roastDate"].toString()),
                      ],
                    ),
                  ),
                ),
            
              ],
            );

  }


  Future<void> updatePurchase(mapToUpdate) async {
    try {
      await beanPurchaseCaller.updatePurchase(mapToUpdate, user, data["id"]);
    } catch (e) {
      print("Error updating purchase: $e with input $mapToUpdate and user $user");
    }
  }
  
}