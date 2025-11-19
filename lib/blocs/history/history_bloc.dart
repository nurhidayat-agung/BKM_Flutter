import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/history_resp.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _historyRepository;

  HistoryBloc(this._historyRepository) : super(HistoryInitial()) {
    on<HistoryEvent>((event, emit) async {
      try {
        emit(const HistoryLoading());
        final response = await _historyRepository.getCompletedDeliveryOrders();
        try {
          // final listHistory = (jsonDecode(response.body) as List)
          //     .map((x) => HistoryResp.fromJson(x))
          //     .toList();
          emit(HistorySuccess([]));
        } catch (e) {
          emit(const HistorySuccess([]));
        }
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });
  }

}
