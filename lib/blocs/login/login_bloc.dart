import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/login/login_resp.dart';
import 'package:newbkmmobile/repositories/login_form_repository.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final UserDetailRepository _userDetailRepository;
  final LoginFormRepository _loginFormRepository;

  LoginBloc(
      this._loginRepository,
      this._userDetailRepository,
      this._loginFormRepository,
      ) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        try {
          emit(const LoginLoading());

          // 🔹 Panggil login API
          final resultLogin = await _loginRepository.login(
            event.username,
            event.password,
          );

          if (resultLogin.status == 200) {
            emit(LoginSuccess(resultLogin));
          } else {
            emit(LoginError(resultLogin.message ?? "Login gagal"));
          }
        } catch (e) {
          emit(LoginError("Terjadi kesalahan: ${e.toString()}"));
        }
      }
    });
  }
}
