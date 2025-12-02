import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';

/// Repository
class LeaveRepository {
  Future<void> submitLeave(String start, String end, String reason) async {
    // panggilan API
    await Future.delayed(const Duration(seconds: 2));

    if (reason.toLowerCase().contains("sakit")) {
      throw Exception(
        "Gagal mengajukan cuti: Alasan 'Sakit' harus dilengkapi surat dokter.",
      );
    }
  }
}

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LeaveRepository repository;

  LeaveBloc(this.repository) : super(LeaveInitial()) {
    on<SubmitLeave>(_onSubmitLeave);
  }

  Future<void> _onSubmitLeave(
      SubmitLeave event,
      Emitter<LeaveState> emit,
      ) async {
    emit(LeaveLoading());

    try {
      await repository.submitLeave(
        event.startDate,
        event.endDate,
        event.reason,
      );

      emit(
        const LeaveSuccess(
          message: "Pengajuan cuti berhasil diajukan!",
        ),
      );
    } catch (e) {
      emit(
        LeaveFailure(
          error: e.toString(),
        ),
      );
    }
  }
}

