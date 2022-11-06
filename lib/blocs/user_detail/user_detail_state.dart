part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();
}

class UserDetailInitial extends UserDetailState {
  @override
  List<Object> get props => [];
}

class UserDetailLoading extends UserDetailState {
  const UserDetailLoading();
  @override
  List<Object> get props => [];
}

class UserDetailSuccess extends UserDetailState {
  final List<UserDetailLocal> listUserDetailLocal;
  const UserDetailSuccess(this.listUserDetailLocal);
  @override
  List<Object> get props => [listUserDetailLocal];
}

class UserDetailError extends UserDetailState {
  final String message;
  const UserDetailError(this.message);
  @override
  List<Object> get props => [message];
}
