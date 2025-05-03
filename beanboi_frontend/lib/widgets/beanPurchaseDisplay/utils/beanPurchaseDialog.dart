import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDropdown.dart';
import 'package:beanboi_frontend/widgets/commonUtils/datePicker.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';

import '../../commonUtils/appRoutes.dart';

class BeanPurchaseDialog extends StatelessWidget {
  final Map<String, dynamic> initialValues;
  final Map<String, dynamic> mapToEdit = {
    "name": "",
    "beanId": "",
    "pricePaid": 0.0,
    "amountPurchased": 0.0,
    "dateOfPurchase": DateTime.now(),
    "dateOfRoast":  DateTime.now(),
  };
  String? selectedBeanId = null;
  bool selectedRoastDate = false;
  bool selectedPurchaseDate = false;
  final String buttonText;
  late List<Map<String, dynamic>> beans;
  bool formComplete = false;
  final Userprefs prefs = Userprefs();
  final bool isUpdate;

  BeanPurchaseDialog({
    required this.isUpdate,
    required this.initialValues,
    required this.buttonText,
    required this.beans,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final prefs = Userprefs();

    return AlertDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: 0,
                top: 0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 16,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GetFormField(initialValues, mapToEdit, "name",
                        "Enter purchase name", "Name"),
                    datePickerItem("Purchase Date", "dateOfPurchase", false),
                    datePickerItem("Roast Date", "dateOfRoast", true),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          beanDropdown(
                            beans: beans,
                            selectedBeanId: initialValues["beanId"],
                            onChanged: (newId) {
                              selectedBeanId = newId;
                              mapToEdit["beanId"] =
                                  newId; 
                            },
                          ),
                          OutlinedButton(
                              onPressed: () => Navigator.of(context)
                                  .push(appRoutes.routeToBeans()),
                              child: Text("New bean ?")),
                        ]),
                    GetFormFieldWithValidator(
                        initialValues,
                        mapToEdit,
                        "pricePaid",
                        "Enter the price paid for the purchase",
                        "Price",
                        decimalValidator,
                        (newValue) => mapToEdit["pricePaid"] =
                            num.tryParse(newValue ?? '')),
                    GetFormFieldWithValidator(
                        initialValues,
                        mapToEdit,
                        "amountPurchased",
                        "Enter the amount purchased",
                        "Amount",
                        decimalValidator,
                        (newValue) => mapToEdit["amountPurchased"] =
                            num.tryParse(newValue ?? '')),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          child: Text(buttonText),
                          onPressed: () {
                            print("pressed button");
                            print("mapToEdit: $mapToEdit");
                            print("initialValues: $initialValues");
                            if (_formKey.currentState!.validate() && ((selectedBeanId != null && selectedPurchaseDate && selectedRoastDate) || isUpdate)) {
                              print("form is valid");
                              if (isUpdate && selectedBeanId == null) {
                                mapToEdit["beanId"] = initialValues["beanId"];
                              }; 
                              if (isUpdate && !selectedRoastDate) {
                                mapToEdit["dateOfRoast"] = initialValues["dateOfRoast"].toIso8601String();
                              };
                              if (isUpdate && !selectedPurchaseDate) {
                                mapToEdit["dateOfPurchase"] = initialValues["dateOfPurchase"].toIso8601String();
                              };
                              mapToEdit["beanId"] = mapToEdit["beanId"] ?? initialValues["beanId"];
                              _formKey.currentState!.save();
                              selectedBeanId = null;
                              selectedRoastDate = false;
                              selectedPurchaseDate = false;
                              Navigator.of(context).pop(mapToEdit);
                            }
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? decimalValidator(value) {
    return (value != null && RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(value))
        ? null
        : 'Only decimal numbers are allowed.';
  }

  Padding datePickerItem(String label, String field, bool isRoastDate) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: prefs.smallInputTextSurface),
            datePicker(
              initialDate: initialValues[field],
              onDateSelected: (date) {
                isRoastDate ? selectedRoastDate = true : selectedPurchaseDate = true;
                mapToEdit[field] = date?.toIso8601String();
              },
            ),
          ],
        ));
  }

  Padding GetFormField(
      Map<dynamic, dynamic> initialValues,
      Map<dynamic, dynamic> mapToUpdate,
      String keyToEdit,
      String hintText,
      String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: prefs.smallInputTextSurface,
        initialValue: initialValues[keyToEdit],
        decoration: InputDecoration(hintText: hintText, labelText: labelText),
        onSaved: (newValue) => mapToUpdate[keyToEdit] = newValue,
      ),
    );
  }

  Map<dynamic, dynamic> getUpdatedMap() {
    return mapToEdit;
  }

  Padding GetFormFieldWithValidator(
      Map<dynamic, dynamic> initialValues,
      Map<dynamic, dynamic> mapToUpdate,
      String keyToEdit,
      String hintText,
      String labelText,
      FormFieldValidator<String>? validator,
      FormFieldSetter<String>? onSaved) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: prefs.smallInputTextSurface,
        validator: validator,
        initialValue: initialValues[keyToEdit].toString(),
        decoration: InputDecoration(hintText: hintText, labelText: labelText),
        onSaved: onSaved,
      ),
    );
  }
}
