import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/controllers/grinderCaller.dart'
    as grinderCaller;

class GrinderDialog extends StatefulWidget {
  final Map<dynamic, dynamic> initialValues;
  final String buttonText;

  GrinderDialog({
    required this.initialValues,
    required this.buttonText,
  });

  @override
  _GrinderDialogState createState() => _GrinderDialogState();

  
}

class _GrinderDialogState extends State<GrinderDialog> {

  
  bool formComplete = false;
  final _formKey = GlobalKey<FormState>();
  final Userprefs prefs = Userprefs();

  final Map<String, dynamic> mapToAdd = {
    "name": "",
    "isActive": true,
    "settings": "",
  };
  
  List<Widget> settingWidgets = [];

  List<int> inputStyles = [0];
  List<Map<String, dynamic>> settingOptions = [{"type": "A"}];

  @override
void initState() {
  super.initState();


if (widget.initialValues.containsKey("settings") && widget.initialValues["settings"] != null) {
  var settings = widget.initialValues["grindSettingRequests"];
  print(settings);
  settingOptions = settings.map<Map<String, dynamic>>((s) {
    return <String, dynamic>{...s};
  }).toList();
  inputStyles = settings.map<int>((s) {
    return s["type"] == "F" ? 1 : s["type"] == "I" ? 2 : 0;
  }).toList();
} else {
  settingOptions = [{"type": "A"}];
  inputStyles = [0];
}
}

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
                    GetFormField(widget.initialValues, mapToAdd, "name","Enter grinder name", "Name"),
                    Column(
                      children: 
                      [
                        
                        for (int i = 0; i < settingOptions.length; i++)
                        GetSettingSelector(i),
                        ElevatedButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              settingOptions.add({"type": "A"});
                              inputStyles.add(0);
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: Text(widget.buttonText),
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
            value: settingOptions[index]["type"] == "A"? "Alphabetical" : settingOptions[index]["type"] == "I" ? "Numeric": "Decimal",
            items: const [
              DropdownMenuItem(value: "Alphabetical", child: Text("Alphabetical")),
              DropdownMenuItem(value: "Decimal", child: Text("Decimal")),
              DropdownMenuItem(value: "Numeric", child: Text("Numeric")),
            ],
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  List<Map<String, dynamic>> newOptions =
                      List.from(settingOptions);
                  newOptions[index] = {
                    ...newOptions[index],
                    "type": value == "Alphabetical"
                        ? "A"
                        : value == "Decimal"
                            ? "F"
                            : "I",
                  };

                  if (value == "Decimal") {
                    newOptions[index]["precision"] = "0.1";
                    inputStyles[index] = 1;
                  } else if (value == "Numeric") {
                    inputStyles[index] = 2;
                  } else {
                    inputStyles[index] = 0;
                  }

                  settingOptions = newOptions;
                });
              }
            },
          ),
          _getInputDelimitors(inputStyles[index], index),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: widget.initialValues["settings"] != null &&
                          widget.initialValues["settings"].length > index
                      ? widget.initialValues["settings"][index]["precision"]?.toString() ?? "0.1"
                      : "0.1",
                  items: const [
                    DropdownMenuItem(value: "0.1", child: Text("0.1")),
                    DropdownMenuItem(value: "0.01", child: Text("0.01")),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        List<Map<String, dynamic>> newOptions =
                            List.from(settingOptions);
                        newOptions[index] = {
                          ...newOptions[index],
                          "precision": value
                        };
                        settingOptions = newOptions;
                      });
                    }
                  },
                ),
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
        initialValue: widget.initialValues["grindSettingRequests"] != null &&
                widget.initialValues["grindSettingRequests"].length > indexToUpdate
            ? widget.initialValues["grindSettingRequests"][indexToUpdate][keyToEdit]?.toString() ?? ""
            : "",
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
        onSaved: (newValue) {
          if (newValue != null) {
            settingOptions[indexToUpdate][keyToEdit] = newValue;
          }
        },
      ),
    ),
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
