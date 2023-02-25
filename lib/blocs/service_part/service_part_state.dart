part of 'service_part_bloc.dart';

abstract class ServicePartState extends Equatable {
  const ServicePartState();
}

class ServicePartInitial extends ServicePartState {
  @override
  List<Object> get props => [];
}

class ServicePartLoading extends ServicePartState {
  const ServicePartLoading();
  @override
  List<Object> get props => [];
}

class ServicePartSuccess extends ServicePartState {
  final List<DataServicePart> listDataServicePart;
  const ServicePartSuccess(this.listDataServicePart);
  @override
  List<Object> get props => [listDataServicePart];
}

class FilterServicePartSuccess extends ServicePartState {
  final List<DataServicePart> listDataServicePart;
  const FilterServicePartSuccess(this.listDataServicePart);
  @override
  List<Object> get props => [listDataServicePart];
}

class ServicePartError extends ServicePartState {
  final String message;
  const ServicePartError(this.message);
  @override
  List<Object> get props => [message];
}