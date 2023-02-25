part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();
}

class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}

class LogoutLoading extends LogoutState {
  const LogoutLoading();
  @override
  List<Object> get props => [];
}

class LogoutSuccess extends LogoutState {
  final String message;
  const LogoutSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class LogoutError extends LogoutState {
  final String message;
  const LogoutError(this.message);
  @override
  List<Object> get props => [message];
}