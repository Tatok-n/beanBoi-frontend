import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:beanboi_frontend/controllers/grinderCaller.dart'
    as grinderCaller;

class GrinderDialog extends StatefulWidget {
  final Map<dynamic, dynamic> initialValues;
  final String buttonText;
  int smallScreenThreashold = 300;

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
      content: Container(
        width: 600,
        height: 800,
        child: SingleChildScrollView(
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
                      
                      
                       Container(
            child: Column(
                        children: 
                        [
                          for (int i = 0; i < settingOptions.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: GetSettingSelector(i),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ElevatedButton(
                              child: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  settingOptions.add({"type": "A"});
                                  inputStyles.add(0);
                                });
                              },
                            ),
                          ),
                        ],
                      )),
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
      ),
    );
  }

  Widget GetSettingSelector(int index) {
    return 
              Container(
                decoration: BoxDecoration(
                  color: prefs.colorScheme.surfaceDim,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 1,
                  )],
                ),
                child: Padding(
                      padding: const EdgeInsets.all(0),
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
                    ),
              );
  }

 Widget _getInputDelimitors(int inputStyle, int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < widget.smallScreenThreashold;
        return isSmallScreen ? getSmallScreenLayout(inputStyle, index) : getLargeScreenLayout(inputStyle, index); 
      }
    );
  }


  Widget getSmallScreenLayout(int inputStyle, int index) {
        return Column(
          children: [
            if (inputStyle == 0)
              Column(
                children: [
                  GetFormFieldWithValidator(index, "startLetter", "Enter finest grind", "Start Letter", letterValidator),
                  GetFormFieldWithValidator(index, "endLetter", "Enter coarsest grind", "End Letter", letterValidator),
                ],
              )
              else if (inputStyle == 2)
              Column(
                children: [
                  GetFormFieldWithValidator(index, "startNumerator", "Enter finest grind", "Start Number", intValidator),
                  GetFormFieldWithValidator(index, "endNumerator", "Enter coarsest grind", "End Number", intValidator),
                ],
              )
            else if (inputStyle == 1)
              Column(
                children: [
                  GetFormFieldWithValidator(index, "startNumerator", "Enter finest grind", "Start Number", intValidator),
                  GetFormFieldWithValidator(index, "endNumerator", "Enter coarsest grind", "End Number", intValidator),
                  Text("Precision"),
                  DropdownButton<String>(
                    value: settingOptions[index]["precision"] ?? "0.1",
                    items: const [
                      DropdownMenuItem(value: "0.1", child: Text("0.1")),
                      DropdownMenuItem(value: "0.01", child: Text("0.01")),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          settingOptions[index]["precision"] = value;
                        });
                      }
                    },
                  ),
                ],
              )
          ],
        );
      }



  Widget getLargeScreenLayout(int inputStyle, int index) {
      return Column(
          children: [
            if (inputStyle == 0)
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetFormFieldWithValidator(index, "startLetter", "Enter finest grind", "Start Letter", letterValidator),
                  GetFormFieldWithValidator(index, "endLetter", "Enter coarsest grind", "End Letter", letterValidator),
                ],
              )
            else if (inputStyle == 2)
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetFormFieldWithValidator(index, "startNumerator", "Enter finest grind", "Start Number", intValidator),
                  GetFormFieldWithValidator(index, "endNumerator", "Enter coarsest grind", "End Number", intValidator),
                ],
              )
            else if (inputStyle == 1)
              Column(
                children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GetFormFieldWithValidator(index, "startNumerator", "Enter finest grind", "Start Number", intValidator),
                            GetFormFieldWithValidator(index, "endNumerator", "Enter coarsest grind", "End Number", intValidator),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Text("Precision"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: settingOptions[index]["precision"] ?? "0.1",
                                items: const [
                                  DropdownMenuItem(value: "0.1", child: Text("0.1")),
                                  DropdownMenuItem(value: "0.01", child: Text("0.01")),
                                ],
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      settingOptions[index]["precision"] = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  
                
              )
          ],
        );
  }

Padding GetFormField(
    Map<dynamic, dynamic> initialValues,
    Map<String, dynamic> mapToUpdate,
    String keyToEdit,
    String hintText,
    String labelText) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      width: 300,
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
        width: 150,
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
