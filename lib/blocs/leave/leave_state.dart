import 'package:equatable/equatable.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object?> get props => [];
}

class LeaveInitial extends LeaveState {}
class LeaveLoading extends LeaveState {}
class LeaveSuccess extends LeaveState {

  final String message;
  const LeaveSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class LeaveFailure extends LeaveState {
  final String error;

  const LeaveFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
