import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:newbkmmobile/blocs/trip_detail/trip_detail_bloc.dart';
import 'package:newbkmmobile/models/trip/list_new_do_response.dart' show ListNewDoData;
import 'package:newbkmmobile/models/trip/muat_request.dart';
//import 'package:newbkmmobile/models/trip/show_do_response.dart';
import 'package:newbkmmobile/models/trip/v2/do_detail_response.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository _tripRepository;

  TripBloc(this._tripRepository) : super(TripInitial()) {

    // KODE BARU: Fungsi helper untuk ambil trip spesifik
    Future<void> fetchSpecificTrip(String deliveryId, Emitter<TripState> emit) async {
      try {
        final (status, resp) = await _tripRepository.getNewDeliveryOrder();

        if (status == 200 && resp != null && resp.data != null) {
          // Cari DO yang sedang dibuka di list berdasarkan ID
          final delivery = resp.data!.firstWhere(
                (element) => element.id == deliveryId,
            orElse: () => ListNewDoData(id: 'not_found'),
          );

          if (delivery.id != 'not_found') {
            final (detailStatus, tripDetail) =
            await _tripRepository.getDeliveryOrderDetail(id: delivery.id.toString());

            if (detailStatus == 200 && tripDetail != null) {
              emit(TripSuccess(doDetailResponseData: tripDetail, listNewDoData: delivery));
            } else {
              emit(const TripError("Gagal memuat detail pengangkutan"));
            }
          } else {
            emit(const TripError("DO tidak ditemukan. Mungkin sudah ditolak atau dialihkan."));
          }
        } else {
          emit(const TripError("Data Tidak Ditemukan"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    }
    // Fungsi helper untuk ambil trip terbaru
    // Future<void> fetchLatestTrip(Emitter<TripState> emit) async {
    //   emit(const TripLoading());
    //   try {
    //     final (status, resp) = await _tripRepository.getNewDeliveryOrder();
    //
    //     if (status == 200 && resp != null && resp.data != null && resp.data!.isNotEmpty) {
    //       final delivery = resp.data!.first;
    //
    //       final (detailStatus, tripDetail) =
    //       await _tripRepository.getDeliveryOrderDetail(id: delivery.id.toString());
    //
    //       if (detailStatus == 200 && tripDetail != null) {
    //         emit(TripSuccess(
    //           doDetailResponseData: tripDetail,
    //           listNewDoData: delivery,
    //         ));
    //       } else {
    //         emit(const TripError("Data Tidak Ditemukan"));
    //       }
    //     } else {
    //       emit(const TripError("Data Tidak Ditemukan"));
    //     }
    //   } catch (e) {
    //     emit(TripError(e.toString()));
    //   }
    // }
    // KODE BARU: Event untuk halaman TripListPage (Nampilin List)
    on<GetTripList>((event, emit) async {
      emit(const TripLoading());
      try {
        final (status, resp) = await _tripRepository.getNewDeliveryOrder();
        if (status == 200 && resp != null && resp.data != null) {
          emit(TripListLoaded(resp.data!));
        } else {
          emit(const TripError("Gagal memuat antrean DO"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });

    // KODE BARU: Event untuk halaman TripPage (Nampilin Detail)
    on<GetTripDetailEvent>((event, emit) async {
      emit(const TripLoading());
      await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
    });

    // // Event GetTrip
    // on<GetTrip>((event, emit) async {
    //   await fetchLatestTrip(emit);
    // });

    // Event AcceptTrip
    on<AcceptTrip>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, response) = await _tripRepository.acceptDeliveryOrder(
          id: event.deliveryOrderDetailId,
        );

        if (status == 200) {
          // Jika berhasil, langsung fetch trip terbaru
          await fetchSpecificTrip(event.deliveryOrderDetailId, emit);
          // await fetchLatestTrip(emit);
        } else {
          emit(TripError("Gagal menerima trip"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });


    on<PushMuat>((event, emit) async {
      emit(const TripLoading());

      try {

        // --- Cek apakah ada DO sambungan ---
        final hasLinked =
            event.deliveryData.linkedDetail != null &&
                (event.deliveryData.linkedDetailId?.isNotEmpty ?? false);


        // --- Siapkan data sambungan ---
        final spbSambung    = hasLinked ? event.muatRequest.spbSambung : null;
        final tarraSambung  = hasLinked ? event.muatRequest.tarraSambung : null;
        final brutoSambung  = hasLinked ? event.muatRequest.brutoSambung : null;
        final nettoSambung  = hasLinked ? event.muatRequest.nettoSambung : null;

        final (status, response) = await _tripRepository.submitMuat(
          nextStatus: "4",
          note: "muat selesai",
          doDetailId: event.deliveryData.id ?? "",
          isEdit: event.isEdit,
          loadBruto: event.muatRequest.bruto,
          loadQuantity: event.muatRequest.netto,
          loadTare: event.muatRequest.tarra,
          spbNumber: event.muatRequest.spb,
          imgSpbLoad: event.muatRequest.fotoSpb,
          spbNumberLink: spbSambung,
          loadBrutoLink: brutoSambung,
          loadQuantityLink: nettoSambung,
          loadTareLink: tarraSambung,
        );
        // Pengecekan agar aplikasi tidak stuck/blank saat error
        if (status == 200 || status == 201) {
          await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
        } else {
          emit(TripError("Gagal menyimpan data MUAT. Server merespons dengan kode: $status"));
        }

        // // await fetchLatestTrip(emit);
        // await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });


    on<PushBongkar>((event, emit) async {
      emit(const TripLoading());

      try {

        // --- Cek apakah ada DO sambungan ---
        final hasLinked =
            event.deliveryData.linkedDetail != null &&
                (event.deliveryData.linkedDetailId?.isNotEmpty ?? false);


        // --- Siapkan data sambungan ---
        final tarraSambung  = hasLinked ? event.bongkarRequest.tarraSambung : null;
        final brutoSambung  = hasLinked ? event.bongkarRequest.brutoSambung : null;
        final nettoSambung  = hasLinked ? event.bongkarRequest.nettoSambung : null;

        final (status, response) = await _tripRepository.submitBongkar(
          nextStatus: "6",
          note: "bongkar selesai",
          doDetailId: event.deliveryData.id ?? "",
          isEdit: event.isEdit,
          unloadBruto: event.bongkarRequest.bruto,
          unloadQuantity: event.bongkarRequest.netto,
          unloadTare: event.bongkarRequest.tarra,
          imgSpbLoad: event.bongkarRequest.fotoSpb,
          unloadBrutoLink: brutoSambung,
          unloadQuantityLink: nettoSambung,
          unloadTareLink: tarraSambung
        );
        // Pengecekan agar aplikasi tidak stuck/blank saat error
        if (status == 200 || status == 201) {
          await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
        } else {
          emit(TripError("Gagal menyimpan data BONGKAR. Server merespons dengan kode: $status"));
        }

        // // await fetchLatestTrip(emit);
        // await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });


    // Event AcceptTrip
    on<LoadingLocationTrip>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, response) = await _tripRepository.changeStatusTrip(
          id: event.deliveryOrderDetailId,
          nextStatus: event.nextStatus,
          note: ""
        );

        if (status == 200) {
          // Jika berhasil, langsung fetch trip terbaru
          await fetchSpecificTrip(event.deliveryOrderDetailId, emit);
          // await fetchLatestTrip(emit);
        } else {
          emit(TripError("Gagal menerima trip"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });

    on<PushTripUnload>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, response) = await _tripRepository.changeStatusTrip(
            id: event.deliveryData.id ?? "",
            nextStatus: "4",
            note: ""
        );

        if (status == 200) {
          // Jika berhasil, langsung fetch trip terbaru
          await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
          // await fetchLatestTrip(emit);
        } else {
          emit(TripError("Gagal menerima trip"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });

    on<PushTillUnload>((event, emit) async {
      emit(const TripLoading());

      try {
        final (status, response) = await _tripRepository.changeStatusTrip(
            id: event.deliveryData.id ?? "",
            nextStatus: "5",
            note: ""
        );

        if (status == 200) {
          // Jika berhasil, langsung fetch trip terbaru
          await fetchSpecificTrip(event.deliveryData.id ?? "", emit);
          // await fetchLatestTrip(emit);
        } else {
          emit(TripError("Gagal menerima trip: $status"));
        }
      } catch (e) {
        emit(TripError(e.toString()));
      }
    });
  }
}



