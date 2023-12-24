import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final String? title;
  const CustomTextInput({Key? key, this.controller, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: title, prefixIcon: Icon(icon)),
    );
  }
}
