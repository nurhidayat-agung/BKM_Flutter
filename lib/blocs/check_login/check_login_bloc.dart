import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/login/UserSession.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';

part 'check_login_event.dart';
part 'check_login_state.dart';

class CheckLoginBloc extends Bloc<CheckLoginEvent, CheckLoginState> {
  final LoginRepository _loginRepository;

  CheckLoginBloc(this._loginRepository) : super(CheckLoginInitial()) {
    on<CheckLogin>((event, emit) async {
      emit(const CheckLoginLoading());
      try {
        final session = await _loginRepository.getUserSession();

        if (session != null && session.userId?.isNotEmpty == true) {
          // ✅ UserSession ditemukan → langsung login
          emit(CheckLoginSuccess(session));
        } else {
          // 🚫 Tidak ada session → arahkan ke halaman login
          emit(const CheckLoginSuccess(null));
        }
      } catch (e) {
        emit(CheckLoginError(e.toString()));
      }
    });
  }
}
