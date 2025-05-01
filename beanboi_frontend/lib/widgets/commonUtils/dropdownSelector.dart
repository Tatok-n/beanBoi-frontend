import 'package:beanboi_frontend/widgets/commonUtils/userPrefs.dart';
import 'package:flutter/material.dart';

class dataDropdown extends StatelessWidget {
  late List<Map<String, dynamic>> data = [];
  late String user = "user0";
  final String label;
  final Userprefs userprefs = Userprefs();
  dataDropdown(this.data, this.user, {super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> items = [];
    for (var i = 0; i < data.length; i++) {
      items.add({"name": data[i]["name"], "id": data[i]["id"].toString()});
    }
    String selectedValue = items[0]["id"].toString();
    return Container(
      decoration: BoxDecoration(
        color: userprefs.colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: userprefs.colorScheme.secondary, width: 2),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: userprefs.onPrimaryContainerSmallHeading,
          border: InputBorder.none,
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item["id"],
            child: Text(item["name"]!),
          );
        }).toList(),
        onChanged: (value) {
          selectedValue = value!;
        },
        value: selectedValue,
      ),
    );
  }

}