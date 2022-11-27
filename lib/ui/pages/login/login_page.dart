import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/login/login_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:newbkmmobile/ui/pages/drawer_menu_page.dart';
import 'package:newbkmmobile/ui/widgets/custom_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc(LoginRepository(), UserDetailRepository());
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isHiddenPassword = true;

  @override
  void initState() {
    super.initState();
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.colorPrimary,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocProvider(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomLoading(message: R.strings.loadingGetData);
                  }
                );
              }
              if (state is LoginSuccess) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const DrawerMenuPage())
                );
              } else if (state is LoginError) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message)));
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 100.0),
                          Column(
                            children: [
                              Image.asset(
                                R.assets.icBKM,
                                height: 80.0,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.center,
                            child: Text(R.strings.vendorName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(40.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(R.strings.titleLogin,
                                      style: TextStyle(
                                        color: R.colors.colorPrimary,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey[350]!,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.blue[600]!,
                                          ),
                                      ),
                                      labelText: R.strings.titleUsername,
                                    ),
                                    style: TextStyle(
                                      color: R.colors.colorText,
                                      fontSize: 18.0,
                                    ),
                                    controller: _usernameController,
                                  ),
                                  const SizedBox(height: 30.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey[350]!,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.blue[600]!,
                                          ),
                                      ),
                                      labelText: R.strings.titlePassword,
                                      suffixIcon: InkWell(
                                        onTap: _togglePasswordView,
                                        child: Icon(
                                          _isHiddenPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.blue[600]!,
                                        ),
                                      ),
                                    ),
                                    obscureText: _isHiddenPassword,
                                    style: TextStyle(
                                      color: R.colors.colorText,
                                      fontSize: 18.0,
                                    ),
                                    controller: _passwordController,
                                  ),
                                  const SizedBox(height: 40.0),
                                  GestureDetector(
                                    onTap: () {
                                      if (_usernameController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            content: Text(R.strings.msgFormNotComplete),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(
                                                  R.strings.ok,
                                                  style: TextStyle(
                                                    color: R.colors.colorPrimary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        _loginBloc.add(
                                          Login(
                                            username: _usernameController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 55.0,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: R.colors.grey1,
                                              offset: const Offset(2.0, 4.0),
                                              blurRadius: 5.0,
                                              spreadRadius: 2.0,
                                            )
                                          ],
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.deepPurple[800]!,
                                              Colors.deepPurple[400]!,
                                            ],
                                          )
                                      ),
                                      child: Text(
                                        R.strings.titleLogin,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
            ),
          ),
        ),
      ),
    );
  }
}
