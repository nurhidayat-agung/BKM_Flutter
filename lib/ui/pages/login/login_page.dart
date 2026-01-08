
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/login/login_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/login_form_repository.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:newbkmmobile/ui/pages/drawer_menu_page.dart';
import 'package:newbkmmobile/ui/widgets/bkm_loading.dart';
import 'package:newbkmmobile/ui/widgets/custom_loading.dart';


class BottomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(0, size.height * 0.8);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc =
  LoginBloc(LoginRepository(), UserDetailRepository(), LoginFormRepository());
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _isHiddenPassword : false,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFF002E5B),
            width: 1.5,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _isHiddenPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black54,
            size: 20,
          ),
          onPressed: _togglePasswordView,
        )
            : null,
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // === PERBAIKAN: Mencegah Scaffold mengubah ukuran body saat keyboard muncul ===
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginLoading) {
              BkmLoading.show(context, message: "mohon tunggu");
              // showDialog(
              //   barrierDismissible: false,
              //   context: context,
              //   builder: (context) =>
              //       CustomLoading(message: R.strings.loadingGetData),
              // );
            } else if (state is LoginSuccess) {
              BkmLoading.hide(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const DrawerMenuPage()),
              );
            } else if (state is LoginError) {
              // Navigator.of(context).pop();
              BkmLoading.hide(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: BottomDiagonalClipper(),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF002E5B),
                            Color(0xFFFF5B2E),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 🔹 Konten utama login
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

                    return SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: viewInsets),
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 60),

                                Image.asset(
                                  "assets/1.png",
                                  height: 180,
                                  fit: BoxFit.contain,
                                  color: null,
                                ),
                                const SizedBox(height: 2),

                                const Text(
                                  "Selamat Datang di BKM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "Silahkan masuk dengan akun anda.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 48),

                                // 🔹 Username Field
                                _buildTextField(
                                  controller: _usernameController,
                                  hintText: "username",
                                ),
                                const SizedBox(height: 16),

                                // 🔹 Password Field
                                _buildTextField(
                                  controller: _passwordController,
                                  hintText: "password",
                                  isPassword: true,
                                ),
                                const SizedBox(height: 28),

                                // 🔹 Tombol Masuk
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF002E5B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 2,
                                    ),
                                    onPressed: () {
                                      if (_usernameController.text.trim().isEmpty ||
                                          _passwordController.text.trim().isEmpty) {
                                        // Logika error
                                      } else {
                                        _loginBloc.add(Login(
                                          username: _usernameController.text.trim(),
                                          password: _passwordController.text.trim(),
                                        ));
                                      }
                                    },
                                    child: const Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                // 🔹 Versi Aplikasi (Di atas gradasi)
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "Versi 0.3.7 / IN - Staging",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}