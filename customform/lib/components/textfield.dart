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
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 44, 44, 44),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  displayIcon.icon,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              validator: customvalidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              autocorrect: true,
              autofillHints: const [AutofillHints.email],
            ),
          ),
        ),
      ],
    );
  }
}
