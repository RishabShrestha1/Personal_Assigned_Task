import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLabels extends StatelessWidget {
  final String texts;

  const TextLabels({Key? key, required this.texts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texts,
      style: GoogleFonts.oswald(
        fontSize: 14,
      ),
    );
  }
}
