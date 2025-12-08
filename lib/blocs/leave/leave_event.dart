import 'package:equatable/equatable.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object?> get props => [];
}

class SubmitLeave extends LeaveEvent {
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;

  const SubmitLeave({
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
  });

  @override
  List<Object?> get props => [leaveType, startDate, endDate, reason];
}
