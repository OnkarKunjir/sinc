import 'package:flutter/material.dart';
import './colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData sincTheme(ThemeData base) {
  return base.copyWith(
    primaryColor: kPrimary,
    scaffoldBackgroundColor: kScaffoldBackground,
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: kPrimary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      base.textTheme,
    ),
  );
}
