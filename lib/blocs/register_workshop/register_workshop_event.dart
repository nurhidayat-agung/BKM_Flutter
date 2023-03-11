part of 'register_workshop_bloc.dart';

abstract class RegisterWorkshopEvent extends Equatable {
  const RegisterWorkshopEvent();
}

class RegisterWorkshop extends RegisterWorkshopEvent {
  final String reason;

  const RegisterWorkshop({
    required this.reason
  });

  @override
  List<Object> get props => [reason];

  @override
  String toString() => "RegisterWorkshop { reason: $reason }";
}