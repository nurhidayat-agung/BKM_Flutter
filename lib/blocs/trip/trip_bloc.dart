import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/new_trip/delivery_response.dart' show DeliveryData;
import 'package:newbkmmobile/models/trip_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository _tripRepository;

  TripBloc(this._tripRepository) : super(TripInitial()) {
    on<Trip>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, resp) = await _tripRepository.getNewDeliveryOrder();

        if (status == 200 && resp != null) {
          // resp.data adalah List<DeliveryData>
          emit(TripSuccess(resp.data ?? []));
        } else {
          emit(const TripSuccess([])); // kosong tapi bukan error
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });
  }
}

