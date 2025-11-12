// part of 'user_detail_bloc.dart';
//
// abstract class UserDetailState extends Equatable {
//   const UserDetailState();
// }
//
// class UserDetailInitial extends UserDetailState {
//   @override
//   List<Object> get props => [];
// }
//
// class UserDetailLoading extends UserDetailState {
//   @override
//   List<Object> get props => [];
// }
//
// class UserDetailSuccess extends UserDetailState {
//   final UserDetailResp userDetailResp;
//   const UserDetailSuccess(this.userDetailResp);
//   @override
//   List<Object> get props => [userDetailResp];
// }
//
// class UserDetailError extends UserDetailState {
//   final String message;
//   const UserDetailError(this.message);
//   @override
//   List<Object> get props => [message];
// }

part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object?> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailSuccess extends UserDetailState {
  final UserDetailResp userDetail;

  const UserDetailSuccess(this.userDetail);

  @override
  List<Object?> get props => [userDetail];
}

class UserDetailError extends UserDetailState {
  final String message;

  const UserDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
