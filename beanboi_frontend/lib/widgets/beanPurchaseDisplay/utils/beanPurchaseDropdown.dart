import 'package:beanboi_frontend/controllers/beanCaller.dart';
import 'package:flutter/material.dart';


class beanDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> beans;
  final String? selectedBeanId;
  final Function(String?) onChanged;

  const beanDropdown({
    super.key,
    required this.beans,
    required this.selectedBeanId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedBeanId,
      hint: const Text("Select a bean"),
      items: beans.map((Map bean) {
        return DropdownMenuItem<String>(
          value: bean["id"].toString(),
          child: Text(bean["name"]),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
