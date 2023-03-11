import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/login_local.dart';
import 'package:newbkmmobile/models/user_detail_resp.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'check_login_event.dart';
part 'check_login_state.dart';

class CheckLoginBloc extends Bloc<CheckLoginEvent, CheckLoginState> {
  final LoginRepository _loginRepository;
  final UserDetailRepository _userDetailRepository;

  CheckLoginBloc(
      this._loginRepository,
      this._userDetailRepository
      ) : super(CheckLoginInitial()) {
    on<CheckLoginEvent>((event, emit) async {
      if (event is CheckLogin) {
        try {
          emit(const CheckLoginLoading());
          final response = await _loginRepository.getLoginLocal();
          if (response.isNotEmpty && response[0].userId.isNotEmpty) {
            final responseUserDetail = await _userDetailRepository.getUserDetailRemote();
            if (responseUserDetail.statusCode == 200) {
              await _userDetailRepository.deleteAllUserDetailLocal();
              final resultUserDetail = UserDetailResp.fromJson(jsonDecode(responseUserDetail.body));
              await _userDetailRepository.addUserDetailLocal(resultUserDetail.toLocal());
            }
            emit(CheckLoginSuccess(response));
          } else {
            emit(CheckLoginSuccess(response));
          }
        } catch (e) {
          emit(CheckLoginError(e.toString()));
        }
      }
    });
  }

}
