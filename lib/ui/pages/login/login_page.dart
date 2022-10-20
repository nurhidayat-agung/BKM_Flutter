import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/login_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/ui/pages/drawer_menu_page.dart';
import 'package:newbkmmobile/ui/widgets/background_image.dart';
import 'package:newbkmmobile/ui/widgets/custom_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc(LoginRepository());
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

  // Widget _logoImage() {
  //   return Container(
  //     height: 60.0,
  //     child: Image.asset(
  //       R.assets.icBKM,
  //       fit: BoxFit.contain,
  //     ),
  //   );
  // }
  //
  // Widget _usernameTextField() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     child: TextField(
  //       decoration: InputDecoration(
  //         fillColor: R.colors.colorPrimary,
  //         labelText: "User Name",
  //         floatingLabelBehavior: FloatingLabelBehavior.auto,
  //       ),
  //       style: const TextStyle(fontSize: 20),
  //       controller: _usernameController,
  //     ),
  //   );
  // }
  //
  // Widget _passwordTextField() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     child: TextField(
  //       decoration: InputDecoration(
  //         fillColor: R.colors.colorPrimary,
  //         labelText: "Password",
  //         floatingLabelBehavior: FloatingLabelBehavior.auto,
  //         suffixIcon: InkWell(
  //           onTap: _togglePasswordView,
  //           child: Icon(
  //             _isHiddenPassword
  //                 ? Icons.visibility_off
  //                 : Icons.visibility,
  //             color: R.colors.colorPrimary,
  //           ),
  //         ),
  //       ),
  //       obscureText: _isHiddenPassword,
  //       style: const TextStyle(fontSize: 20),
  //       controller: _passwordController,
  //     ),
  //   );
  // }
  //
  // Widget _loginButton(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (_usernameController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
  //         showDialog(
  //           context: context,
  //           builder: (ctx) => AlertDialog(
  //             content: const Text("Mohon lengkapi semua data"),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(ctx).pop();
  //                 },
  //                 child: const Text("OK"),
  //               ),
  //             ],
  //           ),
  //         );
  //       } else {
  //         _loginBloc.add(
  //             Login(
  //               username: _usernameController.text,
  //               password: _passwordController.text,
  //             ),
  //         );
  //       }
  //     },
  //     child: Container(
  //       height: 55,
  //       width: MediaQuery.of(context).size.width,
  //       padding: const EdgeInsets.symmetric(vertical: 15),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(const Radius.circular(10)),
  //           boxShadow: <BoxShadow>[
  //             BoxShadow(
  //               color: R.colors.grey1,
  //               offset: const Offset(2, 4),
  //               blurRadius: 5,
  //               spreadRadius: 2,
  //             )
  //           ],
  //           gradient: LinearGradient(
  //               begin: Alignment.centerLeft,
  //               end: Alignment.centerRight,
  //               colors: [
  //                 R.colors.bgGrey,
  //                 R.colors.bgGrey,
  //               ],
  //           )
  //       ),
  //       child: const Text(
  //         "Login",
  //         style: TextStyle(
  //           fontSize: 20,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: BlocProvider(
              create: (context) => _loginBloc,
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) async {
                  if (state is LoginLoading) {
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return const CustomLoading();
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
                      return Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 120),
                                    Column(
                                      children: [
                                        Image.asset(
                                          R.assets.icBKM,
                                          height: 60.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                    Text(R.strings.vendorName),
                                    const SizedBox(height: 100.0),
                                    Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            fillColor: R.colors.colorPrimary,
                                            labelText: R.strings.titleUsername,
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                          ),
                                          style: const TextStyle(fontSize: 20),
                                          controller: _usernameController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            fillColor: R.colors.colorPrimary,
                                            labelText: R.strings.titlePassword,
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            suffixIcon: InkWell(
                                              onTap: _togglePasswordView,
                                              child: Icon(
                                                _isHiddenPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: R.colors.colorPrimary,
                                              ),
                                            ),
                                          ),
                                          obscureText: _isHiddenPassword,
                                          style: const TextStyle(fontSize: 20),
                                          controller: _passwordController,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 60),
                                    GestureDetector(
                                      onTap: () {
                                        if (_usernameController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              content: Text(R.strings.msgFormNotComplete),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text(R.strings.ok),
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
                                            boxShadow: <BoxShadow>[
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
                                                R.colors.bgGrey,
                                                R.colors.bgGrey,
                                              ],
                                            )
                                        ),
                                        child: Text(
                                          R.strings.titleLogin,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
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
                      );
                    },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
