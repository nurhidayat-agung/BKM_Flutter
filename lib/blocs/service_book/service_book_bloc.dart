import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/service_book_resp.dart';
import 'package:newbkmmobile/repositories/service_book_repository.dart';

part 'service_book_event.dart';
part 'service_book_state.dart';

class ServiceBookBloc extends Bloc<ServiceBookEvent, ServiceBookState> {
  final ServiceBookRepository _serviceBookRepository;

  ServiceBookBloc(this._serviceBookRepository) : super(ServiceBookInitial()) {
    on<ServiceBookEvent>((event, emit) async {
      if (event is ServiceBook) {
        try {
          emit(const ServiceBookLoading());
          final response = await _serviceBookRepository.getServiceBook();
          final resultServiceBook = ServiceBookResp.fromJson(jsonDecode(response.body));
          if (resultServiceBook.status == 200) {
            emit(ServiceBookSuccess(resultServiceBook.data ?? []));
          } else {
            emit(ServiceBookError(resultServiceBook.message.toString()));
          }
        } catch (e) {
          emit(ServiceBookError(e.toString()));
        }
      }
    });
  }

}
