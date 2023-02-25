import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/replacement_part_history_resp.dart';
import 'package:newbkmmobile/repositories/service_part_repository.dart';

part 'replacement_part_history_event.dart';
part 'replacement_part_history_state.dart';

class ReplacementPartHistoryBloc extends Bloc<ReplacementPartHistoryEvent, ReplacementPartHistoryState> {
  final ServicePartRepository _servicePartRepository;

  ReplacementPartHistoryBloc(this._servicePartRepository) : super(ReplacementPartHistoryInitial()) {
    on<ReplacementPartHistoryEvent>((event, emit) async {
      if (event is ReplacementPartHistory) {
        try {
          emit(const ReplacementPartHistoryLoading());
          final response = await _servicePartRepository.getReplacementPartHistory(event.itemId);
          final resultReplacementPartHistory = ReplacementPartHistoryResp.fromJson(jsonDecode(response.body));
          if (resultReplacementPartHistory.status == 200) {
            emit(ReplacementPartHistorySuccess(resultReplacementPartHistory.data ?? []));
          } else {
            emit(ReplacementPartHistoryError(resultReplacementPartHistory.message.toString()));
          }
        } catch (e) {
          emit(ReplacementPartHistoryError(e.toString()));
        }
      }
    });
  }
}
