import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color blackColor = Color.fromRGBO(57, 57, 57, 1);
}

class PathContants {
  static String image(image) {
    return 'assets/images/$image';
  }
}

TextStyle textStyle = GoogleFonts.oswald(
  textStyle: const TextStyle(
      color: Colors.blue, fontSize: 30, fontWeight: FontWeight.w500),
);
