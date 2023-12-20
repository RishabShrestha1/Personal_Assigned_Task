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
      padding: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: DropdownButton<String>(
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
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          ],
        ),
        icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.white,
        ),
        value: selectedGender,
        underline: Container(
          height: 2,
          color: const Color.fromARGB(0, 33, 149, 243),
        ),
      ),
    );
  }
}
