import 'package:flutter/material.dart';

var cumuloTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00BFA6),
      secondary: Color(0xFF00BFA6),
      surface: Color(0xFF121212),
      background: Color(0xFF121212),
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
          displaySmall: const TextStyle(
              fontSize: 24, fontFamily: 'Comfortaa', color: Colors.white),
        ));
