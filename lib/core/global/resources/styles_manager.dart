
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/global/resources/values_manager.dart';

import 'font_manager.dart';


TextStyle _getTextStyle(
    FontWeight fontWeight,
    double fontSize,
    double? letterSpacing,
    Color? color,
    ) {
  return GoogleFonts.inter(
    fontWeight: fontWeight,
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    color: color,
  );
}

// light textStyle
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  double? letterSpacing = AppSize.s1,
  Color? color,
}) {
  return _getTextStyle(
    FontWeightManager.light,
    fontSize,
    letterSpacing,
    color,
  );
}

// regular textStyle
TextStyle getRegularStyle({
  double fontSize = FontSize.s16,
  double? letterSpacing = AppSize.s1,
  Color? color,
}) {
  return _getTextStyle(
    FontWeightManager.regular,
    fontSize,
    letterSpacing,
    color,
  );
}

// Medium textStyle
TextStyle getMediumStyle({
  double fontSize = FontSize.s20,
  double? letterSpacing = AppSize.s1,
  Color? color,
}) {
  return _getTextStyle(
    FontWeightManager.medium,
    fontSize,
    letterSpacing,
    color,
  );
}

// Semi-Bold textStyle
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  double? letterSpacing = AppSize.s1,
  Color? color,
}) {
  return _getTextStyle(
    FontWeightManager.semiBold,
    fontSize,
    letterSpacing,
    color,
  );
}

// Bold textStyle
TextStyle getBoldStyle({
  double fontSize = FontSize.s22,
  double? letterSpacing = AppSize.s1,
  Color? color,
}) {
  return _getTextStyle(
    FontWeightManager.bold,
    fontSize,
    letterSpacing,
    color,
  );
}
