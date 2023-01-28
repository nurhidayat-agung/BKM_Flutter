import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/ui/pages/login/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: R.strings.appName,
      theme: ThemeData(
        primaryColor: R.colors.colorPrimary,
        appBarTheme: AppBarTheme(
          color: R.colors.colorPrimary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: R.colors.colorAccent),
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
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
