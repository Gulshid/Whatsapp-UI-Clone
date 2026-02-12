import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // WhatsApp Brand Colors
  static const Color primaryGreen = Color(0xFF075E54);
  static const Color secondaryGreen = Color(0xFF128C7E);
  static const Color tealGreen = Color(0xFF25D366);
  static const Color lightGreen = Color(0xFFDCF8C6);
  
  // UI Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyMedium = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF757575);
  static const Color divider = Color(0xFFE0E0E0);
  
  // Chat Colors
  static const Color chatBubbleReceived = Color(0xFFFFFFFF);
  static const Color chatBubbleSent = Color(0xFFDCF8C6);
  static const Color chatBackground = Color(0xFFECE5DD);
  
  // Status Colors
  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  static const Color typing = Color(0xFF128C7E);
  
  // Call Colors
  static const Color callGreen = Color(0xFF4CAF50);
  static const Color callRed = Color(0xFFF44336);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF111B21);
  static const Color darkSurface = Color(0xFF1F2C33);
  static const Color darkPrimary = Color(0xFF00A884);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.white,
      
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryGreen,
        secondary: AppColors.tealGreen,
        surface: AppColors.white,
        error: Colors.red,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        elevation: 1,
        centerTitle: false,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.roboto(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        displayMedium: GoogleFonts.roboto(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16.sp,
          color: AppColors.black,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 14.sp,
          color: AppColors.black,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: AppColors.greyDark,
        ),
      ),
      
      iconTheme: IconThemeData(
        color: AppColors.greyDark,
        size: 24.sp,
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.tealGreen,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tealGreen,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.greyLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.tealGreen, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 0,
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        secondary: AppColors.tealGreen,
        surface: AppColors.darkSurface,
        error: Colors.red,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.roboto(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        displayMedium: GoogleFonts.roboto(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16.sp,
          color: AppColors.white,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 14.sp,
          color: AppColors.white,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: AppColors.greyMedium,
        ),
      ),
      
      iconTheme: IconThemeData(
        color: AppColors.greyMedium,
        size: 24.sp,
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
