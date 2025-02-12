import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:beanboi_frontend/widgets/displayUtils/dataCard.dart';
import 'package:beanboi_frontend/widgets/displayUtils/userPrefs.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/controllers/beanCaller.dart' as beanCaller;
import 'package:beanboi_frontend/widgets/displayUtils/beanDialog.dart';

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

  late Beandialog dialog = Beandialog(
    initialValues: addInitialValue,
    buttonText: "Add",
    saveFunction: ()=>{},
  );

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

  Future<void> saveBeans(Map<String, dynamic> bean) async {
    try {
      await beanCaller.saveBean(bean, user, );
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
                builder: (BuildContext context) => dialog,
              );
              if (dialog.formComplete) {
                addBeans(dialog.getUpdatedMap());
                dialog.formComplete = false;
              }
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


  void addBeans(Map<dynamic, dynamic> bean) {
    Map<String, dynamic> updatedBeans = {
        "name": bean["name"],
        "origin": bean["origin"],
        "process": bean["process"],
        "price": bean["price"],
        "roastDegree": bean["roastDegree"],
        "roaster": bean["roaster"],
        "altitude": bean["altitude"],
        "tastingNotes": bean["tastingNotes"],
      };

    saveBeans(updatedBeans).then((_) {
      fetchBeans();
      setState(() {});
    });
                          
  }
}

