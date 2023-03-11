part of 'payslip_bloc.dart';

abstract class PaySlipState extends Equatable {
  const PaySlipState();
}

class PaySlipInitial extends PaySlipState {
  @override
  List<Object> get props => [];
}

class PaySlipLoading extends PaySlipState {
  const PaySlipLoading();
  @override
  List<Object> get props => [];
}

class PaySlipSuccess extends PaySlipState {
  final PaySlipResp paySlipResp;
  const PaySlipSuccess(this.paySlipResp);
  @override
  List<Object> get props => [paySlipResp];
}

class PaySlipError extends PaySlipState {
  final String message;
  const PaySlipError(this.message);
  @override
  List<Object> get props => [message];
}