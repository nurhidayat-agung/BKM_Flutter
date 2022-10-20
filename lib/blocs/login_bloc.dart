import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/storage_helper.dart';
import 'package:newbkmmobile/models/login_resp.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        try {
          emit(const LoginLoading());
          final responseLogin = await _loginRepository.login(event.username, event.password);
          final resultLogin = LoginResp.fromJson(responseLogin.data);
          var storageHelper = StorageHelper();
          storageHelper.setString(Constants.userId, resultLogin.userId ?? "");
          storageHelper.setString(Constants.token, resultLogin.token ?? "");
          storageHelper.setString(Constants.firebaseToken, resultLogin.firebaseToken ?? "");
          storageHelper.setString(Constants.username, event.username);
          storageHelper.setString(Constants.password, event.password);

          final responseUserDetail = await _loginRepository.userDetail();
          storageHelper.setString(Constants.userDetail, jsonEncode(responseUserDetail.data));
          emit(LoginSuccess(resultLogin));
        } catch (e) {
          emit(LoginError(e.toString()));
        }
      }
    });
  }

}
