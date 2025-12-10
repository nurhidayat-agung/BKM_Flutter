import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/leave/leave_list_response.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';

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
      int leaveType = Constants.leaveTypeMap[event.leaveType] ?? 0;

      var (status, response) = await repository.submitLeave(
        leaveType,
        event.startDate,
        event.endDate,
        event.reason,
      );

      if (status != 200) {
        emit(
          LeaveFailure(
            error: "submit cuti gagal",
          ),
        );
        return;
      }

      emit(
        const SubmitLeaveSuccess(
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

      if(status == 200){
        var leaveListResponse = LeaveListResponse.fromJson(response);
        emit(
          GetListLeaveSuccess(
            response: leaveListResponse,
          ),
        );
      }else{
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
