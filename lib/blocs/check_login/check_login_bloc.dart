import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/login_local.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';

part 'check_login_event.dart';
part 'check_login_state.dart';

class CheckLoginBloc extends Bloc<CheckLoginEvent, CheckLoginState> {
  final LoginRepository _loginRepository;

  CheckLoginBloc(this._loginRepository) : super(CheckLoginInitial()) {
    on<CheckLoginEvent>((event, emit) async {
      if (event is CheckLogin) {
        try {
          emit(const CheckLoginLoading());
          final response = await _loginRepository.getLoginLocal();
          emit(CheckLoginSuccess(response));
        } catch (e) {
          emit(CheckLoginError(e.toString()));
        }
      }
    });
  }

}
