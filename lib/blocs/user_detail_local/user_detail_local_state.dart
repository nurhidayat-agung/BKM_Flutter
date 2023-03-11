part of 'user_detail_local_bloc.dart';

abstract class UserDetailLocalState extends Equatable {
  const UserDetailLocalState();
}

class UserDetailLocalInitial extends UserDetailLocalState {
  @override
  List<Object> get props => [];
}

class UserDetailLocalLoading extends UserDetailLocalState {
  @override
  List<Object> get props => [];
}

class UserDetailLocalFromRemoteSuccess extends UserDetailLocalState {
  final List<UserDetailLocal> listUserDetailLocal;
  const UserDetailLocalFromRemoteSuccess(this.listUserDetailLocal);
  @override
  List<Object> get props => [listUserDetailLocal];
}

class UserDetailLocalFromDBSuccess extends UserDetailLocalState {
  final List<UserDetailLocal> listUserDetailLocal;
  const UserDetailLocalFromDBSuccess(this.listUserDetailLocal);
  @override
  List<Object> get props => [listUserDetailLocal];
}


class UserDetailLocalError extends UserDetailLocalState {
  final String message;
  const UserDetailLocalError(this.message);
  @override
  List<Object> get props => [message];
}