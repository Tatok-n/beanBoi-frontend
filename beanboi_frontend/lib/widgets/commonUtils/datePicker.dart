import 'dart:math';

import 'package:flutter/material.dart';

class datePicker extends StatefulWidget {
  const datePicker({super.key});

  @override
  State<datePicker> createState() => _datePickerState();
}

class _datePickerState extends State<datePicker>{
  DateTime? selectedDate;
  DateTime today = DateTime.now();

    Future<void> _selectDate() async {
    int startYear = today.year - 1;
    int endYear = today.year + 1;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(startYear),
      lastDate: DateTime(endYear),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: _selectDate, child: const Text('Select Date'));
  }
}