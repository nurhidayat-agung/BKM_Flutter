import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/leave/leave_list_response.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';
import 'package:newbkmmobile/repositories/master_data_repository.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LeaveRepository repository;

  LeaveBloc(this.repository) : super(LeaveInitial()) {
    on<SubmitLeave>(_onSubmitLeave);
    on<GetListLeave>(_onGetListLeave); // ⬅ Tambahkan handler baru
  }

  // ---------------------------------------------------------------------------
  // 🔵 SUBMIT LEAVE
  // ---------------------------------------------------------------------------
  Future<void> _onSubmitLeave(
    SubmitLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveLoading());

    try {
      var selectedLeave = event.leaveTypes.firstWhere(
        (element) => element.name == event.leaveType,
      );
      String leaveType = selectedLeave.fieldValue ?? "";

      var (status, response) = event.leaveId == null
          ? await repository.submitLeave(
              leaveType,
              event.startDate,
              event.endDate,
              event.reason,
            )
          : await repository.editSubmitLeave(
              event.leaveId ?? "",
              leaveType,
              event.startDate,
              event.endDate,
              event.reason,
            );

      if (status == 200 || status == 201) {
        emit(
          SubmitLeaveSuccess(message: "submit cuti berhasil"),
        );
        return;
      } else {

        // 👇 INI YANG DIUBAH: Kita tangkap dan tampilkan balasan ASLI dari API Bang Gulit
        String errorMessage = "Gagal (Status $status). Balasan API: $response";

        emit(
          LeaveFailure(
            error: errorMessage,
          ),
        );
        return;
      }
    } catch (e) {
      emit(
        LeaveFailure(
          error: e.toString(),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // 🟢 GET LIST LEAVE
  // ---------------------------------------------------------------------------
  Future<void> _onGetListLeave(
    GetListLeave event,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveLoading());

    try {
      final (status, response) = await repository.getLeavesByUser();

      if (status == 200) {
        var leaveListResponse = LeaveListResponse.fromJson(response);
        emit(
          GetListLeaveSuccess(
            response: leaveListResponse,
          ),
        );
      } else {
        emit(
          LeaveFailure(
            error: "ambildata gagal",
          ),
        );
      }
    } catch (e) {
      emit(
        LeaveFailure(
          error: e.toString(),
        ),
      );
    }
  }
}
