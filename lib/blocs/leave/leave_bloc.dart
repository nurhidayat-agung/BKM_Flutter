import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';



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
      int leaveType = Constants.leaveTypeMap[event.leaveType] ?? 0;

      var (status, response) =  await repository.submitLeave(
        leaveType,
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

