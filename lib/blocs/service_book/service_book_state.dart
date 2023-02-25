part of 'service_book_bloc.dart';

abstract class ServiceBookState extends Equatable {
  const ServiceBookState();
}

class ServiceBookInitial extends ServiceBookState {
  @override
  List<Object> get props => [];
}

class ServiceBookLoading extends ServiceBookState {
  const ServiceBookLoading();
  @override
  List<Object> get props => [];
}

class ServiceBookSuccess extends ServiceBookState {
  final List<DataServiceBook> listDataServiceBook;
  const ServiceBookSuccess(this.listDataServiceBook);
  @override
  List<Object> get props => [listDataServiceBook];
}

class ServiceBookError extends ServiceBookState {
  final String message;
  const ServiceBookError(this.message);
  @override
  List<Object> get props => [message];
}