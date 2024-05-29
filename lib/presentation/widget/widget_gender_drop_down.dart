import 'package:flutter/material.dart';

class WidgetGenderDropDown extends StatefulWidget {
  final ValueChanged<String> onGenderSelected;
  final bool isEditing;
  final String? value;
  const WidgetGenderDropDown({super.key, required this.onGenderSelected,  this.isEditing = false, this.value});

  @override
  _WidgetGenderDropDownState createState() => _WidgetGenderDropDownState();
}

class _WidgetGenderDropDownState extends State<WidgetGenderDropDown> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButton<String>(
          hint: widget .isEditing ? Text('Select \nGender') :Text('Select Gender'),
          value: widget.value ?? _selectedGender,
          items: <String>['Male', 'Female', 'Other'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust the vertical padding here
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue;
              widget.onGenderSelected(newValue!); // Call the callback with the selected value
            });
          },
          itemHeight:  widget.isEditing ? 50 :70.0, // Adjust the height here
          underline: widget.isEditing ?  null :Container(
            height: 2,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
