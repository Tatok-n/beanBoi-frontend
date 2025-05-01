import 'package:beanboi_frontend/widgets/PlasmaBackgound/plasma.dart';
import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseCard.dart';
import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDialog.dart';
import 'package:beanboi_frontend/widgets/beanPurchaseDisplay/utils/beanPurchaseDropdown.dart';
import 'package:beanboi_frontend/widgets/beansDisplay/utils/beanCard.dart';
import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/controllers/beanPurchaseCaller.dart' as beanPurchaseCaller;
import 'package:beanboi_frontend/widgets/commonUtils/navBar.dart';

import '../../controllers/beanCaller.dart';

class BeanPurchaseDisplay extends StatefulWidget {
  @override
  _BeanPurchaseDisplay createState() => _BeanPurchaseDisplay();
}

class _BeanPurchaseDisplay extends State<BeanPurchaseDisplay> {
  final _formKey = GlobalKey<FormState>();
  String user = "user0";
  List<Map<String, dynamic>> purchases = [];
  late Map<String, dynamic> purchaseToAdd = new Map();
  late Map<String, dynamic> purchaseToUpdate = new Map();
  List<Map<String, dynamic>> beans = [];
  


  Map<String, String> addInitialValue = {
    "name": "",
    "beanId": "",
    "pricePaid": "",
    "amountPurchased": "",
    "dateOfPurchase": "",
    "dateOfRoast": "",
  };

  late BeanPurchaseDialog dialog;

  bool isLoading = true;
  Userprefs prefs = Userprefs();


  @override
  void initState() {
    super.initState();
    fetchPurchases();
    fetchBeans();
  }

  Future<void> fetchPurchases() async {
    try {
      List<Map<String, dynamic>> fetchedPurchases = await beanPurchaseCaller.getAllPurchases(user);
      setState(() {
        purchases = fetchedPurchases;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching purchases: $e");
    }
  }

  Future<void> fetchBeans() async {
    try {
      List<Map<String, dynamic>> fetchedBeans = await getAllBeans(user);
      setState(() {
        beans = fetchedBeans;
      });
    } catch (e) {
      print("Error fetching beans: $e");
    }
  }

  Future<void> savePurchase(Map<String, dynamic> bean) async {
    try {
      await beanPurchaseCaller.savePurchase(bean, user, );
    } catch (e) {
      print("Error adding beans: $e");
    }
    await fetchPurchases();
  }

  Future<void> updateBeans(beanToUpdate) async {
    try {
      await beanPurchaseCaller.updatePurchase(beanToUpdate, user);
    } catch (e) {
      print("Error updatingBeans beans: $e");
    }
    await fetchPurchases();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlasmaBg(),
        Scaffold(
          appBar: AppBar(
            title: Text('Bean purchases'),
          ),
          drawer: navBar(),
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              purchaseToAdd = {};
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) => dialog,
              );
              if (dialog.formComplete) {
                addPurchase(dialog.getUpdatedMap());
                dialog.formComplete = false;
              }
            },
            label: Text('Add purchase'),
            icon: Icon(Icons.add),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : purchases.isEmpty
                  ? Center(child: Text("No purchases?", style: prefs.smallHeading ))
                  : ListView.builder(
                      itemCount: purchases.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BeanPurchaseCard(
                              purchases[index],
                              () => { 
                                fetchPurchases()},
                                user
                          ),
                        );
                      },
                    ),
        )
      ],
    );
  }


  void addPurchase(Map<dynamic, dynamic> purchase) {
    Map<String, dynamic> updatedPurchase = {
           "name": purchase["name"],
    "beanId": purchase["beanId"],
    "pricePaid": purchase["pricePaid"],
    "amountPurchased": purchase["amountPurchased"],
    "dateOfPurchase": purchase["dateOfPurchase"],
    "dateOfRoast": purchase["dateOfRoast"],
      };

    savePurchase(updatedPurchase).then((_) {
      fetchPurchases();
      setState(() {});
    });
                          
  }
}

