import 'package:beanboi_frontend/widgets/displayUtils/dataCard.dart';
import 'package:flutter/material.dart';
import 'package:beanboi_frontend/controllers/beanCaller.dart' as beanCaller;

class BeansDisplay extends StatefulWidget {
  @override
  _BeansState createState() => _BeansState();
}

class _BeansState extends State<BeansDisplay> {
  String user = "user0";
  List<Map> beans = [];
  bool isLoading = true; // Track loading state

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
        isLoading = false; // Data fetched, loading complete
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Loading complete even if there's an error
      });
      print("Error fetching beans: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beans List"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : beans.isEmpty
              ? Center(child: Text("No beans found.")) // Show message if no beans
              : ListView.builder(
                  itemCount: beans.length,
                  itemBuilder: (context, index) {
                    double price = beans[index]['price'];
                    String name = beans[index]['Name'];
                    dataCard card = dataCard();
                    card.name = name;
                    card.valueTopass = price.toString();
                    card.labelTopass = "price";
                    return card.build(context);
                  },
                ),
    );
  }
}