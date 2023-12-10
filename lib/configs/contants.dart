import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color blackColor = Color.fromRGBO(92, 92, 92, 1);
  static const Color primaryColor = Color.fromRGBO(66, 182, 138, 1);
}

class PathContants {
  static String image(image) {
    return 'assets/images/$image';
  }

  static String audio(audio) {
    return 'assets/audio/$audio';
  }
}

TextStyle textStyle = GoogleFonts.oswald(
  textStyle: const TextStyle(
      color: AppColors.blackColor, fontSize: 24, fontWeight: FontWeight.w700),
);
