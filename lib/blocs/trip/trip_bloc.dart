import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/trip_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository _tripRepository;

  TripBloc(this._tripRepository) : super(TripInitial()) {
    on<TripEvent>((event, emit) async {
      try {
        emit(const TripLoading());
        final response = await _tripRepository.getTrip();
        try {
          final listTrip = (response.data as List)
              .map((x) => TripResp.fromJson(x))
              .toList();
          emit(TripSuccess(listTrip));
        } catch (e) {
          emit(TripSuccess([]));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });
  }

}
