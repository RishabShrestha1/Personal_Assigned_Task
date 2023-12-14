import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './form.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyApp(),
    ),
  );
}
