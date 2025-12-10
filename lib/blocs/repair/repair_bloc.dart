import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/models/repair/vehicle_repair_response.dart';
import 'package:newbkmmobile/repositories/repair_repository.dart';
import 'repair_event.dart';
import 'repair_state.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  final RepairRepository repository;

  RepairBloc(this.repository) : super(RepairInitial()) {

    // Ambil Data List (event)
    on<FetchRepairs>((event, emit) async {
      emit(RepairLoading());
      try {
        // final data = await repository.getRepairs();
        var (response, result) = await repository.getVehicleRepairsByUser();

        if (response == 200) {
          var dataResult = VehicleRepairResponse.fromJson(result);
          emit(RepairLoaded(dataResult.data ?? []));
        }
        else{
          emit(RepairFailure("data perbaikan tidak ditemukan"));
        }
      } catch (e) {
        emit(RepairFailure(e.toString()));
      }
    });

    // Submit Data Baru (event)
    on<SubmitRepair>((event, emit) async {
      emit(RepairLoading());
      try {
        await repository.submitRepair(
          type: event.type,
          urgency: event.urgency,
          lastKm: event.lastKm,
          description: event.description,
        );
        emit(RepairSuccess("Pengajuan perbaikan berhasil disimpan!"));
        // Refresh data list setelah sukses simpan
        add(FetchRepairs());
      } catch (e) {
        emit(RepairFailure("Gagal menyimpan data"));
      }
    });
  }
}