import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/controllers/grinderCaller.dart'
    as grinderCaller;

class GrinderDialog extends StatelessWidget {
  final Map<dynamic, dynamic> initialValues;
  final String buttonText;
 

  GrinderDialog({
    required this.initialValues,
    required this.buttonText,
  });


  bool formComplete = false;
  final _formKey = GlobalKey<FormState>();
  final Userprefs prefs = Userprefs();
  final Map<String, dynamic> mapToAdd = {
    "name": "",
    "isActive": true,
    "settings" : "",
  };

  List<Map> getUpdatedMap() {
    return settingOptions;
  }

  int inputStyle = 0;
  List<Map<String, dynamic>> settingOptions = [
    {
      "type": "A",
      "startNumerator": "A",
      "endNumerator": "Z",
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(Icons.close, size: 16),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GetFormField(initialValues, mapToAdd, "name",
                        "Enter grinder name", "Name"),
                    GetSettingSelector(0),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: Text(buttonText),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            mapToAdd["settings"] = settingOptions;
                            formComplete = true;
                            Navigator.of(context).pop(mapToAdd);
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

  Widget GetSettingSelector(int index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          DropdownButton<String>(
            value: settingOptions[index]["type"] == "A"
                ? "Alphabetical"
                : settingOptions[index]["type"] == "I"
                    ? "Decimal"
                    : "Numeric",
            items: const [
              DropdownMenuItem(
                  value: "Alphabetical", child: Text("Alphabetical")),
              DropdownMenuItem(value: "Decimal", child: Text("Decimal")),
              DropdownMenuItem(value: "Numeric", child: Text("Numeric")),
            ],
            onChanged: (String? value) {
             
                if (value == "Alphabetical") {
                  inputStyle = 0;
                  settingOptions[index]["type"] = "A";
                } else if (value == "Decimal") {
                  inputStyle = 1;
                  settingOptions[index]["type"] = "I";
                } else {
                  inputStyle = 2;
                  settingOptions[index]["type"] = "F";
                }
              
            },
          ),
          _getInputDelimitors(inputStyle, index),
        ],
      ),
    );
  }

  Widget _getInputDelimitors(int inputStyle, int index) {
    switch (inputStyle) {
      case 0:
        return Row(
          children: [
            GetFormFieldWithValidator(
                index,
                "startLetter",
                "Enter the finest grind setting",
                "Start Letter",
                letterValidator),
            GetFormFieldWithValidator(
                index,
                "endLetter",
                "Enter the coarsest grind setting",
                "End Letter",
                letterValidator),
          ],
        );
      case 1:
        return Column(
          children: [
            Row(
              children: [
                GetFormFieldWithValidator(
                    index,
                    "startNumerator",
                    "Enter the finest grind setting",
                    "Start Number",
                    intValidator),
                GetFormFieldWithValidator(
                    index,
                    "endNumerator",
                    "Enter the coarsest grind setting",
                    "End Number",
                    intValidator),
              ],
            ),
            Row(
              children: [
                const Text("Precision"),
                DropdownButton<String>(
                  value:
                      settingOptions[index]["precision"]?.toString() ?? "0.1",
                  items: const [
                    DropdownMenuItem(value: "0.1", child: Text("0.1")),
                    DropdownMenuItem(value: "0.01", child: Text("0.01")),
                  ],
                  onChanged: (String? value) {
                   
                      settingOptions[index]["precision"] = double.parse(value!);
                    
                  },
                ),
              ],
            ),
          ],
        );
      case 2:
        return Row(
          children: [
            GetFormFieldWithValidator(index, "startNumerator",
                "Enter the finest grind setting", "Start Number", intValidator),
            GetFormFieldWithValidator(index, "endNumerator",
                "Enter the coarsest grind setting", "End Number", intValidator),
          ],
        );
      default:
        return Container();
    }
  }

  Padding GetFormField(
      Map<dynamic, dynamic> initialValues,
      Map<String, dynamic> mapToUpdate,
      String keyToEdit,
      String hintText,
      String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: prefs.smallInputTextSurface,
        initialValue: initialValues[keyToEdit]?.toString() ?? "",
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
        onSaved: (newValue) {
          if (newValue != null) {
            mapToUpdate[keyToEdit] = newValue;
          }
        },
      ),
    );
  }

  Padding GetFormFieldWithValidator(
      int indexToUpdate,
      String keyToEdit,
      String hintText,
      String labelText,
      FormFieldValidator<String>? validator) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
          width: 300,
          child: TextFormField(
            style: prefs.smallInputTextSurface,
            validator: validator,
            initialValue: initialValues[keyToEdit]?.toString() ?? "",
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
            ),
            onSaved: (newValue) {
              if (newValue != null) {
                settingOptions[indexToUpdate][keyToEdit] = newValue;
              }
            },
          )),
    );
  }

  String? intValidator(String? value) {
    return (value != null && RegExp(r'^[0-9]+$').hasMatch(value))
        ? null
        : 'Only whole numbers are allowed.';
  }

  String? letterValidator(String? value) {
    return (value != null && RegExp(r'^[A-Z]$').hasMatch(value))
        ? null
        : 'Only single letters are allowed.';
  }


}


