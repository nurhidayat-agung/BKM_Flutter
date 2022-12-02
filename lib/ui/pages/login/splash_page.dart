import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/ui/pages/drawer_menu_page.dart';
import 'package:newbkmmobile/ui/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _checkLogin();
    });
  }

  Future _checkLogin() async {
    final loginLocal = await LoginRepository().getLoginLocal();
    if (!mounted) return;
    if (loginLocal.isNotEmpty) {
      if (loginLocal[0].userId.isNotEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const DrawerMenuPage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [
                0.5,
                1.0,
              ],
              colors: [
                Colors.indigo[900]!,
                Colors.indigo[400]!,
              ],
            ),
          ),
          child: Center(
            child: Image.asset(
              R.assets.logoBKM,
              scale: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
