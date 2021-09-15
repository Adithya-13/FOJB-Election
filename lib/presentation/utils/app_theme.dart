import 'package:flutter/material.dart';

class AppTheme {

  static const Color blue = Color(0xFF48B9F3);
  static const Color green = Color(0xFF4CA861);
  static const Color darkGreen = Color(0xFF42934A);
  static const Color lightGreen = Color(0xFFDBFDE3);
  static const Color scaffold = Color(0xFFF4F7FA);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Colors.redAccent;
  static Color whiteOpacity = Color(0xFFFFFFFF).withOpacity(0.6);

  ///font size: 36, color: black, fontWeight: bold
  static const TextStyle headline1 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 34,
  );

  ///font size: 24, color: black, fontWeight: bold
  static const TextStyle headline2 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 24,
  );

  ///font size: 20, color: black, fontWeight: bold
  static const TextStyle headline3 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 18,
  );

  ///font size: 16, color: black, fontWeight: normal
  static const TextStyle text1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 16,
  );

  ///font size: 14, color: black, fontWeight: normal
  static const TextStyle text2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 14,
  );

  ///font size: 12, color: black, fontWeight: normal
  static const TextStyle text3 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 12,
  );

  ///font size: 10, color: black, fontWeight: normal
  static const TextStyle subText1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 10,
  );

  ///font size: 8, color: black, fontWeight: normal
  static const TextStyle subText2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 8,
  );

  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: white),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide:
    BorderSide(color: blue),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: red),
  );

  static OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: red),
  );
}