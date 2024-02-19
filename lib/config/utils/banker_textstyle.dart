import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class BankerTextStyle {
  static final TextStyle styleDefault = GoogleFonts.raleway();
  static TextStyle homeTitle = styleDefault.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 25,
  );
  static TextStyle subtitle = styleDefault.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}
