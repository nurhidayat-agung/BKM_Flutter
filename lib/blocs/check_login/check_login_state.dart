part of 'check_login_bloc.dart';

abstract class CheckLoginState extends Equatable {
  const CheckLoginState();
}

class CheckLoginInitial extends CheckLoginState {
  @override
  List<Object?> get props => [];
}

class CheckLoginLoading extends CheckLoginState {
  const CheckLoginLoading();
  @override
  List<Object?> get props => [];
}

class CheckLoginSuccess extends CheckLoginState {
  final UserSession? userSession;
  const CheckLoginSuccess(this.userSession);

  @override
  List<Object?> get props => [userSession];
}

class CheckLoginError extends CheckLoginState {
  final String message;
  const CheckLoginError(this.message);

  @override
  List<Object?> get props => [message];
}
