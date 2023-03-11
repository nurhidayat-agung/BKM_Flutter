import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/change_password/change_password_bloc.dart';
import 'package:newbkmmobile/blocs/login_form/login_form_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/change_password_repository.dart';
import 'package:newbkmmobile/repositories/login_form_repository.dart';
import 'package:newbkmmobile/ui/pages/drawer_menu_page.dart';
import 'package:newbkmmobile/ui/widgets/custom_loading.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _loginFormBloc              = LoginFormBloc(LoginFormRepository());
  final _changePasswordBloc         = ChangePasswordBloc(LoginFormRepository(), ChangePasswordRepository());
  final _oldPasswordController      = TextEditingController();
  final _newPasswordController      = TextEditingController();
  final _confirmPasswordController  = TextEditingController();
  bool _isHiddenOldPassword         = true;
  bool _isHiddenNewPassword         = true;
  bool _isHiddenConfirmPassword     = true;

  @override
  void initState() {
    super.initState();
    _loginFormBloc.add(LoginForm());
  }

  _toggleOldPasswordView() {
    setState(() {
      _isHiddenOldPassword = !_isHiddenOldPassword;
    });
  }

  _toggleNewPasswordView() {
    setState(() {
      _isHiddenNewPassword = !_isHiddenNewPassword;
    });
  }

  _toggleConfirmPasswordView() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginFormBloc>(
            create: (context) => _loginFormBloc,
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => _changePasswordBloc,
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  R.strings.descChangePassword,
                  style: TextStyle(
                    color: R.colors.colorText,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  children: [
                    BlocBuilder<LoginFormBloc, LoginFormState>(
                        bloc: _loginFormBloc,
                        builder: (context, state) {
                          if (state is LoginFormInitial) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is LoginFormLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is LoginFormSuccess) {
                            return oldPasswordTextField(
                                state.listLoginFormLocal[0].password ?? "");
                          } else {
                            return oldPasswordTextField("");
                          }
                        }),
                  ],
                ),
                const SizedBox(height: 20.0),
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
                    labelText: R.strings.titleNewPassword,
                    suffixIcon: InkWell(
                      onTap: _toggleNewPasswordView,
                      child: Icon(
                        _isHiddenNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.blue[600]!,
                      ),
                    ),
                  ),
                  obscureText: _isHiddenNewPassword,
                  style: TextStyle(
                    color: R.colors.colorText,
                    fontSize: 18.0,
                  ),
                  controller: _newPasswordController,
                ),
                const SizedBox(height: 20.0),
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
                    labelText: R.strings.titleConfirmPassword,
                    suffixIcon: InkWell(
                      onTap: _toggleConfirmPasswordView,
                      child: Icon(
                        _isHiddenConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.blue[600]!,
                      ),
                    ),
                  ),
                  obscureText: _isHiddenConfirmPassword,
                  style: TextStyle(
                    color: R.colors.colorText,
                    fontSize: 18.0,
                  ),
                  controller: _confirmPasswordController,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
                    listener: (context, state) {
                      if (state is ChangePasswordLoading) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomLoading(
                                  message: R.strings.loadingSendData);
                            });
                      }
                      if (state is ChangePasswordSuccess) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: Text(state.generalResp.message ?? ""),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const DrawerMenuPage()));
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
                      }
                      if (state is ChangePasswordError) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: Text(state.message),
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
                      }
                    },
                    child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                      bloc: _changePasswordBloc,
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (_oldPasswordController.text.trim().isEmpty ||
                                _newPasswordController.text.trim().isEmpty ||
                                _confirmPasswordController.text.trim().isEmpty) {
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      content: Text(
                                          R.strings.msgConfirmChangePassword),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _changePasswordBloc
                                                  .add(ChangePassword(
                                                oldPassword:
                                                    _oldPasswordController.text,
                                                newPassword:
                                                    _newPasswordController.text,
                                                confirmPassword:
                                                    _confirmPasswordController
                                                        .text,
                                              ));
                                            },
                                            child: Text(R.strings.yes)),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(R.strings.no))
                                      ],
                                    );
                                  });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: R.colors.greenLogo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              R.strings.submit.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField oldPasswordTextField(String oldPassword) {
    _oldPasswordController.text = oldPassword;

    return TextField(
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
        labelText: R.strings.titleOldPassword,
        suffixIcon: InkWell(
          onTap: _toggleOldPasswordView,
          child: Icon(
            _isHiddenOldPassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.blue[600]!,
          ),
        ),
      ),
      obscureText: _isHiddenOldPassword,
      style: TextStyle(
        color: R.colors.colorText,
        fontSize: 18.0,
      ),
      controller: _oldPasswordController,
    );
  }
}
