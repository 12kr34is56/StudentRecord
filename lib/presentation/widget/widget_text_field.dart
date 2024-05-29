import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/student/student_bloc.dart';


class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    this.suffixIcon, this.validator,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 20),
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          return TextFormField(
            onChanged: (value) {
              context.read<StudentBloc>().add(NameChanged(name: value));
            },
            validator: validator,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

          );
        },
      ),
    );
  }
}
