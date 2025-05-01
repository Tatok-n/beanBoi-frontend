import 'package:beanboi_frontend/controllers/beanCaller.dart';
import 'package:flutter/material.dart';


class beanDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> beans;

  const beanDropdown({super.key, required this.beans});

  @override
  _BeanDropdownState createState() => _BeanDropdownState();
}

class _BeanDropdownState extends State<beanDropdown> {
  String? selectedBeanId;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedBeanId,
      hint: const Text("Select a bean"),
      items: widget.beans.map((Map bean) {
        return DropdownMenuItem<String>(
          value: bean["id"].toString(),
          child: Text(bean["name"]),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedBeanId = newValue;
        });
      },
    );
  }
}
