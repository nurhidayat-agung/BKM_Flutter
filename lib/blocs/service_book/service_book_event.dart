part of 'service_book_bloc.dart';

abstract class ServiceBookEvent extends Equatable {
  const ServiceBookEvent();
}

class ServiceBook extends ServiceBookEvent {
  @override
  List<Object> get props => [];
}