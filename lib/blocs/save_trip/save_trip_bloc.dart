import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/debug_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';

part 'save_trip_event.dart';
part 'save_trip_state.dart';

class SaveTripBloc extends Bloc<SaveTripEvent, SaveTripState> {
  final TripRepository _tripRepository;

  SaveTripBloc(this._tripRepository) : super(SaveTripInitial()) {
    on<SaveTripEvent>((event, emit) async {
      if (event is SaveTrip) {
        try {
          emit(const SaveTripLoading());
          final response = await _tripRepository.saveTrip(
              event.id,
              event.statusTrip,
              event.numberOfLoad,
              event.numberOfUnload,
              event.spbNo,
              event.trigger,
              event.spbImg);
          emit(SaveTripSuccess(DebugResp.fromJson(response.data)));
        } catch (e) {
          emit(SaveTripError(e.toString()));
        }
      }
    });
  }
}
