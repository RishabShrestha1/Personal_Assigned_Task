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
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 44, 44, 44),
          shape: BoxShape.rectangle),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          elevation: 0,
          isExpanded: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          dropdownColor: const Color.fromARGB(255, 44, 44, 44),
          items: widget.listFrom.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
            widget.onGenderChanged(selectedGender);
          },
          hint: Row(
            children: [
              Text(
                widget.hint,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.white,
          ),
          value: selectedGender,
        ),
      ),
    );
  }
}
