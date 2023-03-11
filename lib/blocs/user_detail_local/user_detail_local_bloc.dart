import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/user_detail_local.dart';
import 'package:newbkmmobile/models/user_detail_resp.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'user_detail_local_event.dart';
part 'user_detail_local_state.dart';

class UserDetailLocalBloc extends Bloc<UserDetailLocalEvent, UserDetailLocalState> {
  final UserDetailRepository _userDetailRepository;
  
  UserDetailLocalBloc(this._userDetailRepository) : super(UserDetailLocalInitial()) {
    on<UserDetailLocalEvent>((event, emit) async {
      if (event is UserDetailLocalFromRemote) {
        try {
          emit(UserDetailLocalLoading());
          final responseUserDetail = await _userDetailRepository.getUserDetailRemote();
          await _userDetailRepository.deleteAllUserDetailLocal();
          final resultUserDetail = UserDetailResp.fromJson(jsonDecode(responseUserDetail.body));
          await _userDetailRepository.addUserDetailLocal(resultUserDetail.toLocal());
          final response = await _userDetailRepository.getUserDetailLocal();
          emit(UserDetailLocalFromRemoteSuccess(response));
        } catch (e) {
          emit(UserDetailLocalError(e.toString()));
        }
      } else if (event is UserDetailLocalFromDB) {
        try {
          emit(UserDetailLocalLoading());
          final response = await _userDetailRepository.getUserDetailLocal();
          emit(UserDetailLocalFromDBSuccess(response));
        } catch (e) {
          emit(UserDetailLocalError(e.toString()));
        }
      }
    });
  }
}
