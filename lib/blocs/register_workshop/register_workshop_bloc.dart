import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/legacy/register_workshop_resp.dart';
import 'package:newbkmmobile/repositories/workshop_repository.dart';

part 'register_workshop_event.dart';
part 'register_workshop_state.dart';

class RegisterWorkshopBloc extends Bloc<RegisterWorkshopEvent, RegisterWorkshopState> {
  final WorkshopRepository _workshopRepository;

  RegisterWorkshopBloc(this._workshopRepository) : super(RegisterWorkshopInitial()) {
    on<RegisterWorkshopEvent>((event, emit) async {
      if (event is RegisterWorkshop) {
        try {
          emit(RegisterWorkshopLoading());
          final response = await _workshopRepository.registerWorkshop(event.reason);
          final resultRegister = RegisterWorkshopResp.fromJson(jsonDecode(response.body));
          if (resultRegister.status == 200) {
            emit(RegisterWorkshopSuccess(resultRegister));
          } else {
            emit(RegisterWorkshopError(resultRegister.message.toString()));
          }
        } catch (e) {
          emit(RegisterWorkshopError(e.toString()));
        }
      }
    });
  }
}
