part of 'register_workshop_bloc.dart';

abstract class RegisterWorkshopState extends Equatable {
  const RegisterWorkshopState();
}

class RegisterWorkshopInitial extends RegisterWorkshopState {
  @override
  List<Object> get props => [];
}

class RegisterWorkshopLoading extends RegisterWorkshopState {
  @override
  List<Object> get props => [];
}

class RegisterWorkshopSuccess extends RegisterWorkshopState {
  final RegisterWorkshopResp registerWorkshopResp;
  const RegisterWorkshopSuccess(this.registerWorkshopResp);
  @override
  List<Object> get props => [registerWorkshopResp];
}

class RegisterWorkshopError extends RegisterWorkshopState {
  final String message;
  const RegisterWorkshopError(this.message);
  @override
  List<Object> get props => [message];
}