import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/general_resp.dart';
import 'package:newbkmmobile/repositories/change_password_repository.dart';
import 'package:newbkmmobile/repositories/login_form_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final LoginFormRepository _loginFormRepository;
  final ChangePasswordRepository _changePasswordRepository;

  ChangePasswordBloc(
      this._loginFormRepository,
      this._changePasswordRepository,
      ) : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      if (event is ChangePassword) {
        try {
          emit(const ChangePasswordLoading());
          final responseChangePassword = await _changePasswordRepository.changePassword(event.oldPassword, event.newPassword, event.confirmPassword);
          final resultChangePassword = GeneralResp.fromJson(jsonDecode(responseChangePassword.body));
          if (resultChangePassword.status == 200) {
            var responseLoginForm = await _loginFormRepository.getLoginFormLocal();
            responseLoginForm[0].password = event.newPassword;
            await _loginFormRepository.updateLoginFormLocal(responseLoginForm[0]);
            emit(ChangePasswordSuccess(resultChangePassword));
          } else {
            emit(ChangePasswordError(resultChangePassword.message.toString()));
          }

        } catch (e) {
          emit(ChangePasswordError(e.toString()));
        }
      }
    });
  }

}
