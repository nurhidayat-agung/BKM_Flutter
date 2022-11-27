import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/payslip_resp.dart';
import 'package:newbkmmobile/repositories/payslip_repository.dart';

part 'payslip_event.dart';
part 'payslip_state.dart';

class PaySlipBloc extends Bloc<PaySlipEvent, PaySlipState> {
  final PaySlipRepository _paySlipRepository;

  PaySlipBloc(this._paySlipRepository) : super(PaySlipInitial()) {
    on<PaySlipEvent>((event, emit) async {
      if (event is PaySlip) {
        try {
          emit(const PaySlipLoading());
          final response = await _paySlipRepository.getPaySlip(event.month, event.year);
          if (response.data != null) {
            emit(PaySlipSuccess(PaySlipResp.fromJson(response.data)));
          } else {
            emit(PaySlipSuccess(PaySlipResp()));
          }
        } catch (e) {
          emit(PaySlipError(e.toString()));
        }
      }
    });
  }

}
