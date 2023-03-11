import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/check_login/check_login_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:newbkmmobile/ui/pages/drawer_menu_page.dart';
import 'package:newbkmmobile/ui/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _checkLoginBloc = CheckLoginBloc(LoginRepository(), UserDetailRepository());

  @override
  initState() {
    super.initState();
    _checkLoginBloc.add(CheckLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CheckLoginBloc, CheckLoginState>(
        bloc: _checkLoginBloc,
        builder: (context, state) {
          if (state is CheckLoginInitial) {
            return splashLayout();
          } else if (state is CheckLoginLoading) {
            return splashLayout();
          } else if (state is CheckLoginSuccess) {
            Future.delayed(const Duration(seconds: 2), () {
              if (state.listLoginLocal.isNotEmpty) {
                if (state.listLoginLocal[0].userId.isNotEmpty) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const DrawerMenuPage()));
                } else {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginPage()));
                }
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              }
            });

            return splashLayout();
          } else if (state is CheckLoginError) {
            return splashLayout();
          }
          throw ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
        },
      ),
    );
  }

  Center splashLayout() {
    return Center(
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
    );
  }
}
