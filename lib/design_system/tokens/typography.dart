import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  /* ------------------ HEADLINES (Playfair Display) ------------------ */

  static final TextStyle headline1 = GoogleFonts.playfairDisplay(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle headline2 = GoogleFonts.playfairDisplay(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle headline3 = GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  /* ------------------ BODY (Inter) ------------------ */

  static final TextStyle body1 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle body2 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /* ------------------ UI / ACTIONS (Inter Medium) ------------------ */

  static final TextStyle btn = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Inter Medium
    color: AppColors.white,
  );

  static final TextStyle appBar = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500, // Inter Medium
    color: AppColors.textPrimary,
  );
}
