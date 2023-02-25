part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  final GeneralResp generalResp;
  const ChangePasswordSuccess(this.generalResp);
  @override
  List<Object> get props => [generalResp];
}

class ChangePasswordError extends ChangePasswordState {
  final String message;
  const ChangePasswordError(this.message);
  @override
  List<Object> get props => [message];
}
