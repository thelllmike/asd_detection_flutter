import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFFCAF0F8);
const Color loadingColor = Color(0xFF03045E);

const TextStyle textStyle = TextStyle(
  fontFamily: 'Lato',
  fontWeight: FontWeight.w400,
  fontSize: 24,
  letterSpacing: 0,
);

const TextStyle loadingTextStyle = TextStyle(
  fontFamily: 'Lato',
  fontWeight: FontWeight.w400,
  fontSize: 24,
  letterSpacing: 0,
  color: loadingColor,
);

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'Lato',
);
