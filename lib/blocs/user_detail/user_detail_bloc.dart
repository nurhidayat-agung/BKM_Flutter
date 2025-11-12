// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:newbkmmobile/models/user_detail_local.dart';
// import 'package:newbkmmobile/models/user_detail_resp.dart';
// import 'package:newbkmmobile/repositories/user_detail_repository.dart';
//
// part 'user_detail_event.dart';
// part 'user_detail_state.dart';
//
// class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
//   final UserDetailRepository _userDetailRepository;
//
//   UserDetailBloc(this._userDetailRepository) : super(UserDetailInitial()) {
//     on<UserDetailEvent>((event, emit) async {
//       try {
//         emit(UserDetailLoading());
//         final responseUserDetail = await _userDetailRepository.getUserDetailRemote();
//         final resultUserDetail = UserDetailResp.fromJson(jsonDecode(responseUserDetail.body));
//         emit(UserDetailSuccess(resultUserDetail));
//       } catch (e) {
//         emit(UserDetailError(e.toString()));
//       }
//     });
//   }
//
// }

// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:newbkmmobile/models/user_detail_resp.dart';
// import 'package:newbkmmobile/repositories/user_detail_repository.dart';
//
// part 'user_detail_event.dart';
// part 'user_detail_state.dart';
//
// class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
//   final UserDetailRepository _userDetailRepository;
//
//   UserDetailBloc(this._userDetailRepository) : super(UserDetailInitial()) {
//     on<UserDetailFetch>(_onFetchUserDetail);
//   }
//
//   Future<void> _onFetchUserDetail(
//       UserDetailFetch event, Emitter<UserDetailState> emit) async {
//     try {
//       emit(UserDetailLoading());
//
//       final response = await _userDetailRepository.getUserDetailRemote();
//       final data = UserDetailResp.fromJson(jsonDecode(response.body));
//
//       emit(UserDetailSuccess(data));
//     } catch (e) {
//       emit(UserDetailError("Gagal memuat data user: $e"));
//     }
//   }
// }

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/user_detail_resp.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository _userDetailRepository;

  UserDetailBloc(this._userDetailRepository) : super(UserDetailInitial()) {
    on<UserDetailFetch>(_onFetchUserDetail);
  }

  Future<void> _onFetchUserDetail(
      UserDetailFetch event, Emitter<UserDetailState> emit) async {
    try {
      emit(UserDetailLoading());
      final response = await _userDetailRepository.getUserDetailRemote();
      final data = UserDetailResp.fromJson(jsonDecode(response.body));
      emit(UserDetailSuccess(data));
    } catch (e) {
      emit(UserDetailError("Gagal memuat data user: $e"));
    }
  }
}
