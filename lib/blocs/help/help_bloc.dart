import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/help_resp.dart';
import 'package:newbkmmobile/repositories/help_repository.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final HelpRepository _helpRepository;

  HelpBloc(this._helpRepository) : super(HelpInitial()) {
    on<HelpEvent>((event, emit) async {
      if (event is Help) {
        try {
          emit(const HelpLoading());
          final response = await _helpRepository.getHelp();
          try {
            final listHelp = (jsonDecode(response.body) as List)
                .map((x) => HelpResp.fromJson(x))
                .toList();
            emit(HelpSuccess(listHelp));
          } catch (e) {
            emit(const HelpSuccess([]));
          }
        } catch (e) {
          emit(HelpError(e.toString()));
        }
      }
    });
  }

}
