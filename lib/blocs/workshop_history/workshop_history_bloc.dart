import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/history_workshop_resp.dart';
import 'package:newbkmmobile/repositories/workshop_repository.dart';

part 'workshop_history_event.dart';
part 'workshop_history_state.dart';

class WorkshopHistoryBloc extends Bloc<WorkshopHistoryEvent, WorkshopHistoryState> {
  final WorkshopRepository _workshopRepository;

  WorkshopHistoryBloc(this._workshopRepository) : super(WorkshopHistoryInitial()) {
    on<WorkshopHistoryEvent>((event, emit) async {
      try {
        emit(WorkshopHistoryLoading());
        final response = await _workshopRepository.getHistory();
        final resultHistory = HistoryWorkshopResp.fromJson(jsonDecode(response.body));
        if (resultHistory.status == 200) {
          emit(WorkshopHistorySuccess(resultHistory.data ?? []));
        } else {
          emit(WorkshopHistoryError(resultHistory.message.toString()));
        }
      } catch (e) {
        emit(WorkshopHistoryError(e.toString()));
      }
    });
  }
}
