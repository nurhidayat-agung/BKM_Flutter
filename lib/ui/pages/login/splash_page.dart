import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/check_login/check_login_bloc.dart';
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
  final _checkLoginBloc = CheckLoginBloc(LoginRepository());

  @override
  void initState() {
    super.initState();
    _checkLoginBloc.add(CheckLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CheckLoginBloc, CheckLoginState>(
        bloc: _checkLoginBloc,
        listener: (context, state) async {
          if (state is CheckLoginSuccess) {
            await Future.delayed(const Duration(seconds: 2));
            if (!mounted) return;

            if (state.userSession != null &&
                state.userSession!.userId?.isNotEmpty == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DrawerMenuPage()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            }
          }

          if (state is CheckLoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        },
        child: splashLayout(),
      ),
    );
  }

  Widget splashLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.indigo[900]!,
            Colors.indigo[400]!,
          ],
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/bkm_logo_animation.gif',
          width: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

}
