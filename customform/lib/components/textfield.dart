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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 150, 150, 150),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              displayIcon.icon,
              color: Colors.white,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 50, 50, 50),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          validator: customvalidator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
        ),
      ],
    );
  }
}
