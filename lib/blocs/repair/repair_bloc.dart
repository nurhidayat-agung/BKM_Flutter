import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/core/UtilityFunction.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/models/general/general_response.dart';
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
        } else {
          emit(RepairFailure("data perbaikan tidak ditemukan"));
        }
      } catch (e) {
        emit(RepairFailure(e.toString()));
      }
    });

    // Submit Data Baru (event)
    on<SubmitRepair>((event, emit) async {
      emit(RepairLoading());

      var selectedType = event.maintenanceType
          .firstWhere((element) => element.name == event.type)
          .fieldValue;
      var selectedUrgency = event.listUrgencyLevel
          .firstWhere((element) => element.name == event.urgency)
          .fieldValue;

      List<String> listRepair = event.listRepairType
          .where((e) => event.listRepair.contains(e.id))
          .map((e) => e.fieldValue)
          .whereType<String>() // buang null
          .toList();


      try {
        var (intStatus, result) = event.id == null ? await repository.submitRepair(
          type: selectedType ?? "",
          listRepair: listRepair,
          urgency: selectedUrgency ?? "",
          lastKm: event.lastKm,
          description: event.description,
        ) : await repository.updateRepair(
          id: event.id ?? "",
          type: selectedType ?? "",
          listRepair: listRepair,
          urgency: selectedUrgency ?? "",
          lastKm: event.lastKm,
          description: event.description,
        );

        if (intStatus == 200) {

          String message = '';

          final isSuccess = UtilityFunction.isSuccessApiResponse(
            result,
            onMessage: (msg) => message = msg,
          );
          if (isSuccess) {
            emit(RepairSuccess(message));

            // Refresh data list setelah sukses simpan
            // add(FetchRepairs());
          } else {
            emit(RepairFailure(message));
          }
        } else {
          emit(RepairFailure(GeneralResponse.fromJson(result).message ?? ""));
        }


      } catch (e) {
        emit(RepairFailure("Gagal menyimpan data"));
      }
    });
  }
}
