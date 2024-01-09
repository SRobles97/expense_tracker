import 'package:flutter/material.dart';

import 'package:expense_tracker/views/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var kColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 96, 59, 181));

  var kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 5, 99, 125));

  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.onPrimary,
          centerTitle: true,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          shadowColor: kColorScheme.onPrimaryContainer,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimary,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
          centerTitle: true,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          shadowColor: kDarkColorScheme.onPrimaryContainer,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
