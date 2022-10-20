import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/ui/pages/login/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BKM Mobile",
      theme: ThemeData(
        primaryColor: R.colors.colorPrimary,
        colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: R.colors.colorAccent),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: R.colors.colorPrimary),
          focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: R.colors.colorPrimary),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: R.colors.colorPrimary,
        ),
      ),
      home: SplashPage(),
    );
  }
}
