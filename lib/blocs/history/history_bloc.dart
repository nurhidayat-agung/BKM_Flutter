import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/history_resp.dart';
import 'package:newbkmmobile/models/trip_history/delivery_detail_history.dart';
import 'package:newbkmmobile/models/trip_history/history_response.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _historyRepository;

  HistoryBloc(this._historyRepository) : super(HistoryInitial()) {
    on<GetHistory>((event, emit) async {
      try {
        emit(const HistoryLoading());
        final (status, response) = await _historyRepository.getCompletedDeliveryOrders();
        try {
          if (status == 200) {
            final listHistory = HistoryResponse.fromJson(response);
            if (listHistory.data.isNotEmpty) {
              emit(HistorySuccess(listHistory.data));
            } else {
              emit(const HistorySuccess([]));
            }
          }
          else{
            emit(HistoryError("ambil data gagal"));
          }

        } catch (e) {
          emit(const HistorySuccess([]));
        }
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });
  }

}
