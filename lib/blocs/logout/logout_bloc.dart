import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/login_form_repository.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LoginRepository _loginRepository;
  final UserDetailRepository _userDetailRepository;
  final LoginFormRepository _loginFormRepository;

  LogoutBloc(
      this._loginRepository,
      this._userDetailRepository,
      this._loginFormRepository,
      ) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      if (event is Logout) {
        try {
          emit(const LogoutLoading());
          await _loginRepository.deleteAllLoginLocal();
          await _userDetailRepository.deleteAllUserDetailLocal();
          await _loginFormRepository.deleteAllLoginFormLocal();
          emit(LogoutSuccess(R.strings.ok));
        } catch (e) {
          emit(LogoutError(e.toString()));
        }
      }
    });
  }

}
