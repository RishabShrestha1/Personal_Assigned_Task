import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown(
      {Key? key,
      required this.listFrom,
      required this.hint,
      required this.onGenderChanged})
      : super(key: key);
  final List<String> listFrom;
  final String hint;
  final Function(String?) onGenderChanged;

  @override
  // ignore: library_private_types_in_public_api
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: widget.listFrom.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue;
          });
          widget.onGenderChanged(selectedGender);
        },
        hint: Text(widget.hint), // Optional: Add a hint text
        value: selectedGender,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        underline: Container(
          height: 2,
          color: const Color.fromARGB(0, 33, 149, 243),
        ));
  }
}
