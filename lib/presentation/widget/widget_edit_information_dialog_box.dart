import 'package:flutter/material.dart';

class WidgetEditInformationDialogBox extends StatelessWidget {
  final String id;
  final TextEditingController nameController;
  final DateTime dob;
  final String gender;
  final void Function(String name, String gender, DateTime dob) onUpdate;

  const WidgetEditInformationDialogBox({
    Key? key,
    required this.id,
    required this.nameController,
    required this.dob,
    required this.gender,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Student Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 8.0),
          // Add other input fields for gender and dob
          // This is a simplified version, adapt as necessary
          // Assume you have similar controls for gender and dob
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Get the updated values
            final updatedName = nameController.text;
            final updatedGender = gender;
            final updatedDob = dob;

            // Call the update callback
            onUpdate(updatedName, updatedGender, updatedDob);

            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
