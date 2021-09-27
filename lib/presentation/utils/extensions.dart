
import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

extension StyleText on TextStyle {
  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);
  TextStyle get normal => this.copyWith(fontWeight: FontWeight.w500);
  TextStyle get light => this.copyWith(fontWeight: FontWeight.w100);
  TextStyle get scaffold => this.copyWith(color: AppTheme.scaffold);
  TextStyle get red => this.copyWith(color: AppTheme.red);
  TextStyle get green => this.copyWith(color: AppTheme.green);
  TextStyle get lightGreen => this.copyWith(color: AppTheme.lightGreen);
  TextStyle get darkGreen => this.copyWith(color: AppTheme.darkGreen);
  TextStyle get blue => this.copyWith(color: AppTheme.blue);
  TextStyle get black => this.copyWith(color: AppTheme.black);
  TextStyle get white => this.copyWith(color: AppTheme.white);
  TextStyle get whiteOpacity => this.copyWith(color: AppTheme.whiteOpacity);
}

extension StringExtension on String {
  String get firstWord => this.split(' ').first;
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1)}";
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstTofEach => this.split(" ").map((str) => str.capitalize).join(" ");
}