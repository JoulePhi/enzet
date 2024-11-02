import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static const Color black = Color(0xff090A0A);
  static const Color lightBlack = Color(0xff303437);
  static const Color grey = Color(0xffCDCFD0);
  static const Color lightGrey = Color(0xffF2F4F5);
  static const Color darkGrey = Color(0xff979C9E);
  static const double defaultPadding = 16.0;
  static const double mediumPadding = 12.0;
  static const double largePadding = 20.0;
  static const double extraLargePadding = 24.0;
  static const double defaultRadius = 16.0;
  static const double mediumRadius = 12.0;
  static TextStyle textBlack = GoogleFonts.poppins(
    color: black,
  );
  static TextStyle textLightBlack = GoogleFonts.poppins(
    color: lightBlack,
  );
  static TextStyle textGrey = GoogleFonts.poppins(
    color: grey,
  );
  static TextStyle textLightGrey = GoogleFonts.poppins(
    color: lightGrey,
  );
  static TextStyle textDarkGrey = GoogleFonts.poppins(
    color: darkGrey,
  );
}
