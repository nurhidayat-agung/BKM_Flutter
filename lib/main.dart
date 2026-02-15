// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:newbkmmobile/core/r.dart';
// import 'package:newbkmmobile/ui/pages/login/splash_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: R.strings.appName,
//       theme: ThemeData(
//         primaryColor: R.colors.colorPrimary,
//         appBarTheme: AppBarTheme(
//           color: R.colors.colorPrimary,
//         ),
//         colorScheme: ColorScheme.fromSwatch().copyWith(secondary: R.colors.colorAccent),
//         inputDecorationTheme: InputDecorationTheme(
//           labelStyle: TextStyle(color: R.colors.colorPrimary),
//           focusedBorder: UnderlineInputBorder(
//             borderSide:
//             BorderSide(color: R.colors.colorPrimary),
//           ),
//         ),
//         textSelectionTheme: TextSelectionThemeData(
//           cursorColor: R.colors.colorPrimary,
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const SplashPage(),
//     );
//   }
// }

import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ Tambahkan ini untuk inisialisasi locale tanggal
import 'package:newbkmmobile/core/r.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/ui/pages/login/splash_page.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/repositories/langsir_repository.dart';

final Alice alice = Alice(
  configuration: AliceConfiguration(
    showNotification: true,
    showInspectorOnShake: true,
    showShareButton: true,
  )
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await initializeDateFormatting('id_ID', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LangsirBloc>(
            create: (_) => LangsirBloc(LangsirRepository()),
          ),
        ],
    child: MaterialApp(
      navigatorKey: alice.getNavigatorKey(),
      title: R.strings.appName,
      theme: ThemeData(
        primaryColor: R.colors.colorPrimary,
        appBarTheme: AppBarTheme(
          color: R.colors.colorPrimary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: R.colors.colorAccent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: R.colors.colorPrimary),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: R.colors.colorPrimary),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: R.colors.colorPrimary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    ));
  }
}
