import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/blocs/trip_detail/trip_detail_bloc.dart';
import 'package:newbkmmobile/models/new_trip/delivery_response.dart' show DeliveryData;
import 'package:newbkmmobile/models/new_trip/trip_detail_response.dart';
import 'package:newbkmmobile/models/trip_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository _tripRepository;

  TripBloc(this._tripRepository) : super(TripInitial()) {
    // Fungsi helper untuk ambil trip terbaru
    Future<void> fetchLatestTrip(Emitter<TripState> emit) async {
      emit(const TripLoading());
      try {
        final (status, resp) = await _tripRepository.getNewDeliveryOrder();

        if (status == 200 && resp != null && resp.data != null && resp.data!.isNotEmpty) {
          final delivery = resp.data!.first;

          final (detailStatus, tripDetail) =
          await _tripRepository.getDeliveryOrderDetail(id: delivery.id.toString());

          if (detailStatus == 200 && tripDetail != null) {
            emit(TripSuccess(
              tripDetail: tripDetail,
              deliveryData: delivery,
            ));
          } else {
            emit(const TripError("Data Tidak Ditemukan"));
          }
        } else {
          emit(const TripError("Data Tidak Ditemukan"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    }

    // Event GetTrip
    on<GetTrip>((event, emit) async {
      await fetchLatestTrip(emit);
    });

    // Event AcceptTrip
    on<AcceptTrip>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, response) = await _tripRepository.acceptDeliveryOrder(
          id: event.deliveryOrderDetailId,
        );

        if (status == 200) {
          // Jika berhasil, langsung fetch trip terbaru
          await fetchLatestTrip(emit);
        } else {
          emit(TripError("Gagal menerima trip"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });


    // Event AcceptTrip
    on<LoadingLocationTrip>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, response) = await _tripRepository.loadingLocation(
          id: event.deliveryOrderDetailId,
          nextStatus: event.nextStatus,
          note: ""
        );

        if (status == 200) {
          // Jika berhasil, langsung fetch trip terbaru
          await fetchLatestTrip(emit);
        } else {
          emit(TripError("Gagal menerima trip"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });
  }
}



