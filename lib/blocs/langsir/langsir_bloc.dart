import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/models/langsir/local_hauling_response.dart';
import 'package:newbkmmobile/models/langsir_detail/LocalHaulingDetailResponse.dart';
import 'package:newbkmmobile/models/langsir_detail_item/langsir_detail_item_response.dart';
import 'langsir_event.dart';
import 'langsir_state.dart';
import 'package:newbkmmobile/repositories/langsir_repository.dart';

class LangsirBloc extends Bloc<LangsirEvent, LangsirState> {
  final LangsirRepository repository;

  LangsirBloc(this.repository) : super(LangsirInitial()) {
    on<FetchLangsirList>(_onFetchList);
    on<FetchLangsirDetail>(_onFetchDetail);
    on<SaveLangsirMuat>(_onSaveMuat);
    on<SaveLangsirBongkar>(_onSaveBongkar);
    on<SubmitLocalHauling>(_onSubmitLocalHauling);
    on<FetchLangsirDetailItem>(_onFetchDetailItem);
    on<UpdateLangsirDetailItem>(_onUpdateLangsirDetailItem);
  }


  Future<void> _onUpdateLangsirDetailItem(UpdateLangsirDetailItem event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());

    try{
      final (status, result) =
      await repository.updateLangsirDetailItem(
        detailId: event.detailId,
        doId: event.doId,
        spbNumber: event.spbNumber,
        loadQuantity: event.loadQuantity,
        unloadQuantity: event.unloadQuantity,
        loadDate: event.loadDate,
        unloadDate: event.unloadDate,
        actionButton: event.actionButton,
        imgSpbLoad: event.imgSpbLoad,
        imgSpbUnload: event.imgSpbUnload,
      );

      if (status == 200) {
        emit(LangsirSubmitSuccess(result?['message'] ?? 'Berhasil menyimpan data'));
      } else {
        emit(LangsirSubmitFailed(
          result?['message'] ?? 'Gagal menyimpan data',
        ));
      }
    }catch(e){
      emit(LangsirSubmitFailed(e.toString()));
    }
  }


  Future<void> _onFetchList(FetchLangsirList event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());
    try {
      final (intStatusCode, response) = await repository.getOpenLocalHauling();
      if (intStatusCode == 200) {
        LocalHaulingResponse data = LocalHaulingResponse.fromJson(response);
        emit(LangsirListLoaded(data.data ?? []));
      }
      else{
        emit(LangsirFailure("fetch data gagal"));
      }

    } catch (e) {
      emit(LangsirFailure(e.toString()));
    }
  }

  Future<void> _onFetchDetail(FetchLangsirDetail event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());
    try {
      final (status, resp) = await repository.getDeliveryOrderDetail(event.id);
      if (status != 200) {
        emit(LangsirFailure("fetch data gagal"));
        return;
      }
      if (status == 200) {
        final detail = LocalHaulingDetailResponse.fromJson(resp);
        if (detail.status != "success") {
          emit(LangsirFailure("fetch data gagal"));
          return;
        }
        if (detail.data == null) {
          emit(LangsirFailure("fetch data gagal"));
          return;
        }

        emit(LangsirDetailLoaded(detail.data!));
      }

    } catch (e) {
      emit(LangsirFailure(e.toString()));
    }
  }

  Future<void> _onSubmitLocalHauling(
      SubmitLocalHauling event,
      Emitter<LangsirState> emit,
      ) async {
    emit(LangsirLoading());

    try {
      final response = await repository.submitLocalHauling(
        doId: event.doId,
        spbNumber: event.spbNumber,
        loadQuantity: event.loadQuantity,
        unloadQuantity: event.unloadQuantity,
        loadDate: event.loadDate,
        unloadDate: event.unloadDate,
        actionButton: event.actionButton,
        imgSpbLoad: event.imgSpbLoad,
        imgSpbUnload: event.imgSpbUnload,
      );

      if (response.status >= 200 && response.status < 300) {
        emit(LangsirSubmitSuccess(response.result?['message'] ?? 'Berhasil menyimpan data'));
      } else {
        emit(LangsirSubmitFailed(
          response.result?['message'] ?? 'Gagal menyimpan data',
        ));
      }
    } catch (e) {
      emit(LangsirSubmitFailed(e.toString()));
    }
  }

  Future<void> _onSaveMuat(SaveLangsirMuat event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());
    try {
      final msg = await repository.saveMuat(
        event.id,
        event.jumlahMuat,
        event.tanggalMuat,
        event.actionButton,
        event.photoMuat,
      );
      emit(LangsirSuccess(msg));
    } catch (e) {
      emit(LangsirFailure(e.toString()));
    }
  }

  Future<void> _onSaveBongkar(SaveLangsirBongkar event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());
    try {
      final msg = await repository.saveBongkar(
        event.id,
        event.jumlahBongkar,
        event.tanggalBongkar,
        event.actionButton,
        event.photoBongkar,
      );
      emit(LangsirSuccess(msg));
    } catch (e) {
      emit(LangsirFailure(e.toString()));
    }
  }

  Future<void> _onFetchDetailItem(
      FetchLangsirDetailItem event,
      Emitter<LangsirState> emit,
      ) async {
    emit(LangsirLoading());

    try {
      final (status, resp) =
      await repository.getLangsirDetailItem(event.doId);

      if (status != 200) {
        emit(LangsirFailure("fetch langsir detail item gagal"));
        return;
      }

      final parsed = LangsirDetailItemResponse.fromJson(resp);

      if (parsed.status != "success") {
        emit(LangsirFailure("fetch langsir detail item gagal"));
        return;
      }

      if (parsed.data == null) {
        emit(LangsirFailure("data langsir detail item kosong"));
        return;
      }

      emit(FetchLangsirDetailItemSuccess(resp: parsed));
    } catch (e) {
      emit(LangsirFailure(e.toString()));
    }
  }

}
