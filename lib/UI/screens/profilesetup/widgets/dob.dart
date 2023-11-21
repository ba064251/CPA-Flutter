import 'package:flutter/material.dart';

class DateOfBirthWidget extends StatefulWidget {
  final TextEditingController dateController;

  const DateOfBirthWidget({super.key, required this.dateController});

  @override
  _DateOfBirthWidgetState createState() => _DateOfBirthWidgetState();
}

class _DateOfBirthWidgetState extends State<DateOfBirthWidget> {
  DateTime selectedDate = DateTime.now();

  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;
  bool hasSelectedDate = false;

  @override
  void initState() {
    super.initState();
    widget.dateController.text = 'Select Date of Birth'; // Initial hint text
    monthController =
        FixedExtentScrollController(initialItem: selectedDate.month - 1);
    yearController = FixedExtentScrollController(
        initialItem: _getYears().indexOf(selectedDate.year.toString()));
  }

  void updateDateText() {
    final day = selectedDate.day;
    final month = _getMonths()[selectedDate.month - 1];
    final year = selectedDate.year;
    widget.dateController.text = "$day $month $year";
    hasSelectedDate = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.dateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hasSelectedDate ? null : 'Select Date of Birth',
      ),
      onTap: _pickDate,
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        monthController =
            FixedExtentScrollController(initialItem: selectedDate.month - 1);
        yearController = FixedExtentScrollController(
            initialItem: _getYears().indexOf(selectedDate.year.toString()));
        updateDateText();
      });
    }
  }

  List<String> _getMonths() {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
  }

  List<String> _getYears() {
    List<String> years = [];
    int currentYear = DateTime.now().year;
    for (int i = currentYear; i >= 1900; i--) {
      years.add(i.toString());
    }
    return years;
  }

  @override
  void dispose() {
    widget.dateController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }
}
