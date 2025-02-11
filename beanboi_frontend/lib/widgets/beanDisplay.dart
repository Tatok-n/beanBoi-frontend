import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:beanboi_frontend/widgets/displayUtils/dataCard.dart';
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
      await beanCaller.saveBean(beanToAdd, user);
    } catch (e) {
      print("Error adding beans: $e");
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
                builder: (context) => AlertDialog(
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
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter Bean name',
                                    labelText: 'Name'),
                                onSaved: (newValue) =>
                                    beanToAdd["name"] = newValue,
                              ),
                            ),
                                                        Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter Bean Origin',
                                    labelText: 'Origin'),
                                onSaved: (newValue) =>
                                    beanToAdd["origin"] = newValue,
                              ),
                            ),
                                                        Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter the process used',
                                    labelText: 'process'),
                                onSaved: (newValue) =>
                                    beanToAdd["process"] = newValue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter Bean price/100g',
                                    labelText: 'Price'),
                                validator: (value) {
                                  return (value != null &&
                                          RegExp(r'^[0-9]+(\.[0-9]+)?$')
                                              .hasMatch(value))
                                      ? null
                                      : 'Only decimal numbers are allowed.';
                                },
                                onSaved: (value) => beanToAdd["price"] =
                                    double.tryParse(value ?? '') ?? 0.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter roast degree',
                                    labelText: 'Roast degree'),
                                validator: (value) {
                                  return (value != null &&
                                          RegExp(r'^[0-9]+$').hasMatch(value))
                                      ? null
                                      : 'Only whole numbers are allowed.';
                                },
                                onSaved: (newValue) =>
                                    beanToAdd["roastDegree"] =
                                        int.tryParse(newValue ?? ''),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter name of Roaster',
                                    labelText: 'Roaster'),
                                onSaved: (newValue) =>
                                    beanToAdd["roaster"] = newValue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Enter altitude of cultivation',
                                    labelText: 'Altitude'),
                                validator: (value) {
                                  return (value != null &&
                                          RegExp(r'^[0-9]+$').hasMatch(value))
                                      ? null
                                      : 'Only whole numbers are allowed.';
                                },
                                onSaved: (newValue) => beanToAdd["altitude"] =
                                    int.tryParse(newValue ?? ''),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText:
                                        'What does the coffee taste like...',
                                    labelText: 'Tasting notes'),
                                onSaved: (newValue) =>
                                    beanToAdd["tastingNotes"] = newValue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                child: const Text('Add'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Navigator.of(context).pop();
                                    print("Saved value: $beanToAdd");
                                    saveBeans().then((_) {
                                      setState(() {});
                                    });
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
                          child: DataCard(beans[index]),
                        );
                      },
                    ),
        )
      ],
    );
  }
}
