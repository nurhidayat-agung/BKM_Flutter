import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/core/storage_helper.dart';
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
            MaterialPageRoute(builder: (_) => const DrawerMenuPage())
        );
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage())
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.colorPrimary,
      body: Center(
        child: Image.asset(
          R.assets.icBKM,
          scale: 4.0,
        ),
      ),
    );
  }
}
