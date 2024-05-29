import 'package:flutter/material.dart';

class WidgetDatePicker extends StatefulWidget {
  final String helpText;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? initialDate;
  final MaterialStateProperty<Size?>? minimumSize;

  WidgetDatePicker({
    super.key,
    required this.helpText,
    required this.onDateSelected,
    this.minimumSize,
    this.initialDate,
  });

  @override
  State<WidgetDatePicker> createState() => _WidgetDatePickerState();
}

class _WidgetDatePickerState extends State<WidgetDatePicker> {
  late DateTime selectedDate;
  DateTime? picked;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> selectDate(BuildContext context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
        widget.onDateSelected(selectedDate); // Call the callback with the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
          style: ButtonStyle(
            minimumSize: widget.minimumSize,
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor: MaterialStateProperty.all<Color>(Colors.black),
            elevation: MaterialStateProperty.all<double>(2),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
          ),
          onPressed: () => selectDate(context),
          child: SizedBox(
            height: 30,
            width: 110,
            child: Center(
              child: Text(
                selectedDate.toString().substring(0, 10),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
