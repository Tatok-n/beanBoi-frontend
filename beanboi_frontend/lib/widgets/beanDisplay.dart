import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:beanboi_frontend/widgets/displayUtils/dataCard.dart';
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/controllers/beanCaller.dart' as beanCaller;

class BeansDisplay extends StatefulWidget {
  @override
  _BeansState createState() => _BeansState();
}

class _BeansState extends State<BeansDisplay> {
  final _formKey = GlobalKey<FormState>();
  String user = "user0";
  List<Map> beans = [];
  late Map<String, dynamic> beanToAdd = new Map();
  late Map<String, dynamic> beanToUpdate = new Map();
  Map<String, String> addInitialValue = {
    "name": "",
    "origin": "",
    "process": "",
    "price": "",
    "roastDegree": "",
    "roaster": "",
    "altitude": "",
    "tastingNotes": ""
  };
  bool isLoading = true;
  Userprefs prefs = Userprefs();

  @override
  void initState() {
    super.initState();
    fetchBeans();
  }

  Future<void> fetchBeans() async {
    try {
      List<Map> fetchedBeans = await beanCaller.getAllBeans(user);
      setState(() {
        beans = fetchedBeans;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching beans: $e");
    }
  }

  Future<void> saveBeans() async {
    try {
      await beanCaller.saveBean(beanToAdd, user, );
    } catch (e) {
      print("Error adding beans: $e");
    }
    await fetchBeans();
  }

  Future<void> updateBeans(beanToUpdate) async {
    try {
      await beanCaller.updateBean(beanToUpdate, user);
    } catch (e) {
      print("Error updatingBeans beans: $e");
    }
    await fetchBeans();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Plasma(),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              beanToAdd = {};
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) => BeanDialog(context, addInitialValue,beanToAdd,"Add Bean", saveBeans),
              );
            },
            label: Text('Add bean'),
            icon: Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(
              "BEANS",
              style: TextStyle(fontSize: prefs.bigFont),
            ),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : beans.isEmpty
                  ? Center(child: Text("No beans found."))
                  : ListView.builder(
                      itemCount: beans.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DataCard(
                              beans[index],
                              () => { 
                                fetchBeans()},
                                user
                          ),
                        );
                      },
                    ),
        )
      ],
    );
  }

  Widget BeanDialog(context, Map<dynamic, dynamic> initialValues, Map<dynamic, dynamic> mapToEdit, String buttonText, Function saveFunction) => AlertDialog(
      backgroundColor: prefs.black3,
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child:Icon(Icons.close, color: prefs.accent2, size: 16,),
              
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GetFormField(initialValues, mapToEdit, "name", "Enter bean name", "Name"),
                GetFormField(initialValues, mapToEdit, "origin", "Enter bean Origin", "Origin"),
                GetFormField(initialValues, mapToEdit, "process", "Enter the process used", "Process"),
                GetFormFieldWithValidator(initialValues, mapToEdit, "price", "Enter Bean price/100g", "Price", decimalValidator, (value) => mapToEdit["price"] = double.tryParse(value ?? '') ?? 0.0),
                GetFormFieldWithValidator(initialValues, mapToEdit, "roastDegree", "Enter roast Degree", "Roast Degree", intValidator,  (newValue) =>mapToEdit["roastDegree"] = int.tryParse(newValue ?? '')),
                GetFormField(initialValues, mapToEdit, "roaster", "Enter Roaster", "Roaster"),
                GetFormFieldWithValidator(initialValues, mapToEdit, "altitude", "Enter altitude of cultivation", "Altitude", intValidator,  (newValue) =>mapToEdit["altitude"] = int.tryParse(newValue ?? '')),
                GetFormField(initialValues, mapToEdit, "tastingNotes", 'What does the coffee taste like...', "Tasting notes"),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: Text(buttonText),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.of(context).pop();
                        saveFunction();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

  void addBeans() {
    saveBeans().then((_) {
      setState(() {});
    });
                          
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
                  initialValue: initialValues[keyToEdit],
                  decoration: InputDecoration(
                      hintText: hintText,
                      labelText: labelText),
                  onSaved: (newValue) =>
                      mapToUpdate[keyToEdit] = newValue,
                ),
              );

  
  }

  Padding GetFormFieldWithValidator(Map<dynamic, dynamic> initialValues, Map<dynamic, dynamic> mapToUpdate, String keyToEdit, String hintText, String labelText, FormFieldValidator<String>? validator, FormFieldSetter<String>? onSaved) {
    return Padding(
                
                padding: const EdgeInsets.all(8),
                child: TextFormField(
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
