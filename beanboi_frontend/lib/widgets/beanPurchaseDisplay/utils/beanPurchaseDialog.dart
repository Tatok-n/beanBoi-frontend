import 'dart:math';
import 'dart:ui';

import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDropdown.dart';
import 'package:beanboi_frontend/widgets/commonUtils/datePicker.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';


class BeanPurchaseDialog extends StatelessWidget {
  final Map<String, dynamic> initialValues;
  final Map<String, dynamic> mapToEdit = {};
  final String buttonText;
  late List<Map<String, dynamic>> beans;
  bool formComplete = false;
  final Userprefs prefs = Userprefs();

  BeanPurchaseDialog({
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
          padding: const EdgeInsets. only(bottom: 8.0),
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
                    GetFormField(initialValues, mapToEdit, "name", "Enter purchase name", "Name"),
                    datePicker(),
                    datePicker(),
                    beanDropdown(beans : beans),
                    GetFormFieldWithValidator(initialValues, mapToEdit, "pricePaid", "Enter the price paid for the purchase", "Price", intValidator, (newValue) => mapToEdit["price"] = int.tryParse(newValue ?? '')),
                    GetFormFieldWithValidator(initialValues, mapToEdit, "amount", "Enter the amount purchased", "Amount", intValidator, (newValue) => mapToEdit["amount"] = int.tryParse(newValue ?? '')),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: Text(buttonText),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.of(context).pop();
                            formComplete = true;
                          }
                        },
                      ),
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


  String? intValidator(value) {
                      return (value != null &&
                              RegExp(r'^[0-9]+$').hasMatch(value))
                          ? null
                          : 'Only whole numbers are allowed.';
                    }

  String? decimalValidator(value) {
                      return (value != null &&
                              RegExp(r'^[0-9]+(\.[0-9]+)?$')
                                  .hasMatch(value))
                          ? null
                          : 'Only decimal numbers are allowed.';
                    }

  

  Padding GetFormField(Map<dynamic, dynamic> initialValues, Map<dynamic, dynamic> mapToUpdate, String keyToEdit, String hintText, String labelText) {
    return Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  style: prefs.smallInputTextSurface,
                  initialValue: initialValues[keyToEdit],
                   decoration: InputDecoration(
                       hintText: hintText,
                       labelText: labelText),
                  onSaved: (newValue) =>
                      mapToUpdate[keyToEdit] = newValue,
                ),
              );

  
  }

  Map<dynamic, dynamic> getUpdatedMap() {
    return mapToEdit;}

  Padding GetFormFieldWithValidator(Map<dynamic, dynamic> initialValues, Map<dynamic, dynamic> mapToUpdate, String keyToEdit, String hintText, String labelText, FormFieldValidator<String>? validator, FormFieldSetter<String>? onSaved) {
    return Padding(
                
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  style: prefs.smallInputTextSurface,
                  validator : validator,
                  initialValue: initialValues[keyToEdit].toString(),
                  decoration: InputDecoration(
                      hintText: hintText,
                      labelText: labelText),
                  onSaved: onSaved,
                ),
              );
}
}