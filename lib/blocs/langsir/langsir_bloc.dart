import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  Future<void> _onFetchList(FetchLangsirList event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());
    try {
      final list = await repository.fetchList();
      emit(LangsirListLoaded(list));
    } catch (e) {
      emit(LangsirFailure(e.toString()));
    }
  }

  Future<void> _onFetchDetail(FetchLangsirDetail event, Emitter<LangsirState> emit) async {
    emit(LangsirLoading());
    try {
      final detail = await repository.fetchDetail(event.id);
      emit(LangsirDetailLoaded(detail));
    } catch (e) {
      emit(LangsirFailure(e.toString()));
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
}
