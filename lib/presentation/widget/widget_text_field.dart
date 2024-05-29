import 'package:flutter/material.dart';


class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 20),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
