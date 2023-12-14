import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Icon displayIcon;
  final String? Function(String?)? customvalidator;
  final TextEditingController controller;

  const TextInput({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.displayIcon,
    this.customvalidator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          icon: displayIcon,
          hintText: hintText,
          labelText: labelText,
          border: InputBorder.none),
      validator: customvalidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
    );
  }
}
