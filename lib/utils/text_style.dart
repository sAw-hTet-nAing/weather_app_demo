
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/app_color.dart';
import 'package:weather_app/utils/dimesion.dart';

class MyTextStyle {
  static TextStyle heading = GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: Dimesion.font16,
      color: AppColor.mainTextColor);
  static TextStyle headingGrey = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font16,
      color: Colors.grey[500]);
  static TextStyle labelText = GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: Dimesion.font12,
      color: AppColor.mainTextColor);
  static TextStyle titleText = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font16,
      color: AppColor.mainTextColor);
  static TextStyle titleTextGrey = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font16,
      color: Colors.grey[600]);
  static TextStyle smallText = GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: Dimesion.font12 - 3,
      color: AppColor.mainTextColor);
  static TextStyle smallTextGrey = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font12 - 2,
      color: Colors.grey[600]);
  static TextStyle normalText = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font12 - 2,
      color: AppColor.mainTextColor);
  static TextStyle normalTextGrey = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font12 - 2,
      color: Colors.grey[600]);
  static TextStyle tempText = GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: Dimesion.font26,
      color: AppColor.mainTextColor);
  static TextStyle booktittleTextGrey = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font12 - 2,
      color: Colors.grey[400]);
  static TextStyle priceText = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: Dimesion.font12 - 2,
      color: AppColor.buttonColor);
}