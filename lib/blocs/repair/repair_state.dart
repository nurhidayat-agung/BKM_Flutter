import 'package:newbkmmobile/models/repair/repair_model.dart';

abstract class RepairState {}

class RepairInitial extends RepairState {}

class RepairLoading extends RepairState {}

class RepairLoaded extends RepairState {
  final List<RepairModel> repairs;
  RepairLoaded(this.repairs);
}

class RepairSuccess extends RepairState {
  final String message;
  RepairSuccess(this.message);
}

class RepairFailure extends RepairState {
  final String error;
  RepairFailure(this.error);
}