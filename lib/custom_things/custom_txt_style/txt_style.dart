import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

myStyle({Color? color, FontWeight? fontWeight, double? fontSize}){
  return GoogleFonts.roboto(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight
  );
}