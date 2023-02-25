import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/service_part_resp.dart';
import 'package:newbkmmobile/repositories/service_part_repository.dart';

part 'service_part_event.dart';
part 'service_part_state.dart';

class ServicePartBloc extends Bloc<ServicePartEvent, ServicePartState> {
  final ServicePartRepository _servicePartRepository;

  ServicePartBloc(this._servicePartRepository) : super(ServicePartInitial()) {
    on<ServicePartEvent>((event, emit) async {
      if (event is ServicePart) {
        try {
          emit(const ServicePartLoading());
          final response = await _servicePartRepository.getServicePart();
          final resultServicePart = ServicePartResp.fromJson(jsonDecode(response.body));
          if (resultServicePart.status == 200) {
            emit(ServicePartSuccess(resultServicePart.data ?? []));
          } else {
            emit(ServicePartError(resultServicePart.message.toString()));
          }
        } catch (e) {
          emit(ServicePartError(e.toString()));
        }
      } else if (event is FilterServicePart) {
        try {
          emit(const ServicePartLoading());
          emit(FilterServicePartSuccess(event.listDataServicePart));
        } catch (e) {
          emit(ServicePartError(e.toString()));
        }
      }
    });
  }

}
