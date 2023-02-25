import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/trip_detail_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';

part 'trip_detail_event.dart';
part 'trip_detail_state.dart';

class TripDetailBloc extends Bloc<TripDetailEvent, TripDetailState> {
  final TripRepository _tripRepository;

  TripDetailBloc(this._tripRepository) : super(TripDetailInitial()) {
    on<TripDetailEvent>((event, emit) async {
      if (event is TripDetail) {
        try {
          emit(const TripDetailLoading());
          final response = await _tripRepository.getTripDetail(event.id);
          emit(TripDetailSuccess(TripDetailResp.fromJson(jsonDecode(response.body))));
        } catch (e) {
          emit(TripDetailError(e.toString()));
        }
      }
    });
  }
  
}
