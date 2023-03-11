part of 'user_detail_local_bloc.dart';

abstract class UserDetailLocalEvent extends Equatable {
  const UserDetailLocalEvent();
}

class UserDetailLocalFromRemote extends UserDetailLocalEvent {
  @override
  List<Object> get props => [];
}

class UserDetailLocalFromDB extends UserDetailLocalEvent {
  @override
  List<Object> get props => [];
}