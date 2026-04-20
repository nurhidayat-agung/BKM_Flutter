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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final Alice alice = Alice(
  configuration: AliceConfiguration(
    showNotification: true,
    showInspectorOnShake: true,
    showShareButton: true,
  )
);

// =========================================
// KONFIGURASI CHANNEL BANNER (Tanpa Getar)
// =========================================
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
  enableVibration: false,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
// ==========================================

//======================
// BACKGROUND HANDLER //
//======================
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Menangani notif background: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Register Background Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await initializeDateFormatting('id_ID', null);

  // Jalankan Setup FCM untuk ambil token
  await setupFCM();

  runApp(MyApp());
}
//======================
// FUNGSI SETUP FCM //
//======================
Future<void> setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Minta izin ke user
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // Ambil Token
    String? token = await messaging.getToken();
    print("=========================================");
    print("FCM TOKEN: $token");
    print("=========================================");


    //==================================
    // BANNER NOTIFIKASI MELAYANG
    //==================================
    // DAFTAR BANNER CHANNEL KE SISTEM ANDROID
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Matikan popup bawaan FCM saat aplikasi dibuka, agar tidak bentrok
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,

    );//TANGKAP PESAN DAN MUNCULKAN BANNER JIKA PENGANGKUTAN BARU
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification?.title ?? message.data['title'] ?? '';
      String body = message.notification?.body ?? message.data['body'] ?? '';

      // Cek pesan mengandung kata terkait pengangkutan baru
      String textToLower = (title + " " + body).toLowerCase();
      bool isPengangkutanBaru = textToLower.contains('pengangkutan') ||
          textToLower.contains('baru');

      if (isPengangkutanBaru) {
        flutterLocalNotificationsPlugin.show(
          message.hashCode,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/launcher_icon',
              importance: Importance.max,
              priority: Priority.high,
              enableVibration: false,
              playSound: true,
            ),
          ),
        );
      }
    });
    //=============================================
  }
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
