import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';


class Beandialog extends StatelessWidget {
  final Map<dynamic, dynamic> initialValues;
  final Map<dynamic, dynamic> mapToEdit = {};
  final String buttonText;
  bool formComplete = false;
  final Userprefs prefs = Userprefs();

  Beandialog({
    required this.initialValues,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final prefs = Userprefs();
    return AlertDialog(
      backgroundColor: prefs.colorScheme.surfaceBright,
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
                    color: prefs.colorScheme.onSurface,
                    size: 16,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GetFormField(initialValues, mapToEdit, "name", "Enter bean name", "Name"),
                    GetFormField(initialValues, mapToEdit, "origin", "Enter bean Origin", "Origin"),
                    GetFormField(initialValues, mapToEdit, "process", "Enter the process used", "Process"),
                    GetFormFieldWithValidator(initialValues, mapToEdit, "price", "Enter Bean price/100g", "Price", decimalValidator, (value) => mapToEdit["price"] = double.tryParse(value ?? '') ?? 0.0),
                    GetFormFieldWithValidator(initialValues, mapToEdit, "roastDegree", "Enter roast Degree", "Roast Degree", intValidator, (newValue) => mapToEdit["roastDegree"] = int.tryParse(newValue ?? '')),
                    GetFormField(initialValues, mapToEdit, "roaster", "Enter Roaster", "Roaster"),
                    GetFormFieldWithValidator(initialValues, mapToEdit, "altitude", "Enter altitude of cultivation", "Altitude", intValidator, (newValue) => mapToEdit["altitude"] = int.tryParse(newValue ?? '')),
                    GetFormField(initialValues, mapToEdit, "tastingNotes", 'What does the coffee taste like...', "Tasting notes"),
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
                      labelStyle : prefs.smallInputLabelSurface,
                      counterStyle: prefs.smallInputTextSurface,
                      hintText: hintText,
                      hintStyle: prefs.smallInputHintSurface,
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
                      labelStyle : prefs.smallInputLabelSurface,
                      counterStyle: prefs.smallInputTextSurface,
                      hintText: hintText,
                      hintStyle: prefs.smallInputHintSurface,
                      labelText: labelText),
                  onSaved: onSaved,
                ),
              );
}
}