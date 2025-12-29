import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/legacy/history_waiting_list_resp.dart';
import 'package:newbkmmobile/repositories/workshop_repository.dart';

part 'workshop_waiting_list_event.dart';
part 'workshop_waiting_list_state.dart';

class WorkshopWaitingListBloc extends Bloc<WorkshopWaitingListEvent, WorkshopWaitingListState> {
  final WorkshopRepository _workshopRepository;

  WorkshopWaitingListBloc(this._workshopRepository) : super(WorkshopWaitingListInitial()) {
    on<WorkshopWaitingListEvent>((event, emit) async {
      try {
        emit(WorkshopWaitingListLoading());
        final response = await _workshopRepository.getWaitingList();
        final resultHistory = HistoryWaitingListResp.fromJson(jsonDecode(response.body));
        if (resultHistory.status == 200) {
          emit(WorkshopWaitingListSuccess(resultHistory.data ?? []));
        } else {
          emit(WorkshopWaitingListError(resultHistory.message.toString()));
        }
      } catch (e) {
        emit(WorkshopWaitingListError(e.toString()));
      }
    });
  }
}
