import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/legacy/payslip_resp.dart';
import 'package:newbkmmobile/models/payslip/payslip_response_model.dart';
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
          final (status, result) = await _paySlipRepository.getPaySlipByPeriod(event.month, event.year);
          if (status == 200 && result?.data != null && result?.data?.payroll != null) {
            emit(PaySlipSuccess(result!.data!));
          } else {
            emit(PaySlipError(result?.message ?? "Data slip gaji tidak ditemukan"));
          }
        } catch (e) {
          emit(PaySlipError("Terjadi kesalahan: ${e.toString()}"));
        }
      }
    });
  }
}
