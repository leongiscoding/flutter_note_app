import 'package:flutter/material.dart';
import 'package:flutter_note_app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier{
// initialize default theme
ThemeData _themeData = lightMode;

// getter method to access them from other code
ThemeData get themeData => _themeData;

//getter method to see either we are in dark mode or not, used by cupertino switch
bool get isDarkMode => _themeData == darkMode;

// set and notify it when theme has change
set themeData(ThemeData themeData){
  _themeData = themeData;
  notifyListeners();
}

// will use in other part of codes
void toggleTheme(){
  if(_themeData == lightMode){
    themeData = darkMode;
  }else{
    themeData = lightMode;
  }
}

}