part of 'payslip_bloc.dart';

abstract class PaySlipEvent extends Equatable {
  const PaySlipEvent();
}

class PaySlip extends PaySlipEvent {
  final int month;
  final int year;

  const PaySlip({
    required this.month,
    required this.year,
  });

  @override
  List<Object> get props => [month, year];

  @override
  String toString() => "PaySlip { month: $month, year: $year }";
}