import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/legacy/history_detail_resp.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';

part 'history_detail_event.dart';
part 'history_detail_state.dart';

class HistoryDetailBloc extends Bloc<HistoryDetailEvent, HistoryDetailState> {
  final HistoryRepository _historyRepository;

  HistoryDetailBloc(this._historyRepository) : super(HistoryDetailInitial()) {
    on<HistoryDetailEvent>((event, emit) async {
      if (event is HistoryDetail) {
        try {
          emit(const HistoryDetailLoading());
          final response = await _historyRepository.getHistoryDetail(event.id);
          emit(HistoryDetailSuccess(HistoryDetailResp.fromJson(jsonDecode(response.body))));
        } catch (e) {
          emit(HistoryDetailError(e.toString()));
        }
      }
    });
  }

}

