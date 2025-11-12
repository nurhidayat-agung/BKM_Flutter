// part of 'user_detail_bloc.dart';
//
// abstract class UserDetailEvent extends Equatable {
//   const UserDetailEvent();
// }
//
// class UserDetail extends UserDetailEvent {
//   @override
//   List<Object> get props => [];
// }

part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class UserDetailFetch extends UserDetailEvent {}
