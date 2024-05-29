import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key, this.text, this.onTap});

  final String? text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    TextEditingController? passwordController;
    return Container(
        height: 40,
        width: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: InkWell(
          onTap: onTap,
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text!,style: TextStyle(color: Colors.white),),
          ),),
        ));
  }
}
