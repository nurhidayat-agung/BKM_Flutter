import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/common/hive/hive_simple_master.dart';
import 'package:newbkmmobile/models/common/master_data.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object?> get props => [];
}

class GetListLeave extends LeaveEvent {
  const GetListLeave();
  @override
  List<Object?> get props => [];
}

class SubmitLeave extends LeaveEvent {
  final List<HiveSimpleMaster> leaveTypes;
  final String? leaveId;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;

  const SubmitLeave({
    required this.leaveId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.leaveTypes,
  });

  @override
  List<Object?> get props => [leaveId, leaveType, startDate, endDate, reason, leaveTypes];
}
