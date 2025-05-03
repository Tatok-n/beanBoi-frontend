import 'package:beanboi_frontend/controllers/beanCaller.dart';
import 'package:flutter/material.dart';


class beanDropdown extends StatefulWidget {
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
  State<beanDropdown> createState() => _beanDropdownState();
}

class _beanDropdownState extends State<beanDropdown> {
  String? selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.selectedBeanId;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text("Select a bean"),
      value: selectedId,
      items: widget.beans.map((bean) {
        return DropdownMenuItem<String>(
          value: bean["id"].toString(),
          child: Text(bean["name"]),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedId = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
