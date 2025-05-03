import 'dart:math';

import 'package:flutter/material.dart';

class datePicker extends StatefulWidget {
  final void Function(DateTime?) onDateSelected;
  final DateTime? initialDate;
  const datePicker({super.key, required this.onDateSelected, this.initialDate});

  @override
  State<datePicker> createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  DateTime? selectedDate;
  DateTime today = DateTime.now();

  Future<void> _selectDate() async {
    int startYear = today.year - 1;
    int endYear = today.year + 1;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? today,
      firstDate: DateTime(startYear),
      lastDate: DateTime(endYear),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _selectDate,
      child: Text(
        selectedDate == null
            ? 'Select Date'
            : '${selectedDate!.toLocal()}'.split(' ')[0],
      ),
    );
  }
}
