import 'package:flutter/material.dart';
// we will beautify the apps

//light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme:  ColorScheme.light(
    background: Colors.grey.shade300, //for major background
    primary: Colors.grey.shade200, //for widget background
    secondary: Colors.grey.shade400, //for widget background
    inversePrimary: Colors.grey.shade800, //for text color,or button
  ),
);


//dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 24, 24, 24,), //for major background
    primary: const Color.fromARGB(255, 34, 34, 34,),  //for widget background
    secondary: Colors.grey.shade700,  //for widget background
    inversePrimary: Colors.grey.shade300, //for text color
  ),
);