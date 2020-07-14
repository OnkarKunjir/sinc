import 'package:flutter/material.dart';
import './colors.dart';

ThemeData sincTheme(ThemeData base) {
  return base.copyWith(
    primaryColor: kPrimary,
    scaffoldBackgroundColor: kScaffoldBackground,
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: kPrimary,
    ),
  );
}
