part of 'login_form_bloc.dart';

abstract class LoginFormState extends Equatable {
  const LoginFormState();
}

class LoginFormInitial extends LoginFormState {
  @override
  List<Object> get props => [];
}

class LoginFormLoading extends LoginFormState {
  const LoginFormLoading();
  @override
  List<Object> get props => [];
}

class LoginFormSuccess extends LoginFormState {
  final List<LoginFormLocal> listLoginFormLocal;
  const LoginFormSuccess(this.listLoginFormLocal);
  @override
  List<Object> get props => [listLoginFormLocal];
}

class LoginFormError extends LoginFormState {
  final String message;
  const LoginFormError(this.message);
  @override
  List<Object> get props => [message];
}
