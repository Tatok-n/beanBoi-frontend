import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/widgets/commonUtils/navBar.dart';
import 'package:beanboi_frontend/controllers/grinderCaller.dart'
    as grinderCaller;

import '../commonUtils/userPrefs.dart';
import 'utils/grinderCard.dart';
import 'utils/grinderDialog.dart';

class GrinderDisplay extends StatefulWidget {
  @override
  _GrinderState createState() => _GrinderState();


}

class _GrinderState extends State<GrinderDisplay> {

  final _formKey = GlobalKey<FormState>();
  String user = "user0";
  List<Map<String, dynamic>> grinders = [];
  late Map<String, dynamic> grinderToAdd = new Map();
  late Map<String, dynamic> grinderToUpdate = new Map();

  Map<String, String> addInitialValue = {
    "name": "",
  };

  bool isLoading = true;
  Userprefs prefs = Userprefs();

  @override
  void initState() {
    super.initState();
    fetchGrinders();
  }

  Future<void> fetchGrinders() async {
    try {
      List<Map> fetchedGrinders = await grinderCaller.getAllGrinders(user);
      setState(() {
        grinders = List<Map<String, dynamic>>.from(fetchedGrinders);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching grinders: $e");
    }
  }

  Future<void> saveGrinder(Map<String, dynamic> grinder) async {
    try {
      await grinderCaller.saveGrinder(
        grinder,
        user,
      );
    } catch (e) {
      print("Error adding beans: $e");
    }
    await fetchGrinders();
  }

  Future<void> updateBeans(grinderToUpdate) async {
    try {
      await grinderCaller.updateGrinder(grinderToUpdate, user);
    } catch (e) {
      print("Error updatingBeans beans: $e");
    }
    await fetchGrinders();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlasmaBg(),
        Scaffold(
          appBar: AppBar(
            title: Text('Grinders'),
          ),
          drawer: navBar(),
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (BuildContext context) => GrinderDialog(
                  initialValues: addInitialValue,
                  buttonText: "Add",
                  grinderToUpdate: {},
                ),
              );

              if (result!=null) {
                print("Adding grinder");
                addGrinder(result);       
              }
            },
            
            label: Text('Add grinder'),
            icon: Icon(Icons.add),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : grinders.isEmpty
                  ? Center(
                      child: Text("No grinders?", style: prefs.smallHeading))
                  : ListView.builder(
                      itemCount: grinders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GrinderCard(
                              grinders[index], () => {fetchGrinders()}, user),
                        );
                      },
                    ),
        )
      ],
    );
  }

  void addGrinder(Map<dynamic, dynamic> grinder) {
    Map<String, dynamic> updatedGrinder = {
      "name": grinder["name"],
      "settings": grinder["settings"],
      "uid": user,
      "id": grinder["id"],
      "isActive": grinder["isActive"]
    };

    saveGrinder(updatedGrinder).then((_) {
      fetchGrinders();
      setState(() {});
    });
  }
}
