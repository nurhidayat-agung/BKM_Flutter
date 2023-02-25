part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();
}

class LoginForm extends LoginFormEvent {
  @override
  List<Object> get props => [];
}
