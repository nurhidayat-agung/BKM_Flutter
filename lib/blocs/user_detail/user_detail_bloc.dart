import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/user_detail_local.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository _userDetailRepository;

  UserDetailBloc(this._userDetailRepository) : super(UserDetailInitial()) {
    on<UserDetailEvent>((event, emit) async {
      try {
        emit(const UserDetailLoading());
        final response = await _userDetailRepository.getUserDetailLocal();
        emit(UserDetailSuccess(response));
      } catch (e) {
        emit(UserDetailError(e.toString()));
      }
    });
  }

}
