import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/leave/leave_list_response.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object?> get props => [];
}

class LeaveInitial extends LeaveState {}
class LeaveLoading extends LeaveState {}
class SubmitLeaveSuccess extends LeaveState {

  final String message;
  const SubmitLeaveSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class LeaveFailure extends LeaveState {
  final String error;

  const LeaveFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetListLeaveSuccess extends LeaveState{
  final LeaveListResponse response;

  const GetListLeaveSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}
