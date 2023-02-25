part of 'check_login_bloc.dart';

abstract class CheckLoginEvent extends Equatable {
  const CheckLoginEvent();
}

class CheckLogin extends CheckLoginEvent {
  @override
  List<Object> get props => [];
}