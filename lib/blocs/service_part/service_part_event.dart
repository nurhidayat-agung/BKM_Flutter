part of 'service_part_bloc.dart';

abstract class ServicePartEvent extends Equatable {
  const ServicePartEvent();
}

class ServicePart extends ServicePartEvent {
  @override
  List<Object> get props => [];
}

class FilterServicePart extends ServicePartEvent {
  final List<DataServicePart> listDataServicePart;

  const FilterServicePart({
    required this.listDataServicePart
  });

  @override
  List<Object> get props => [listDataServicePart];

  @override
  String toString() => "FilterServicePart { listDataServicePart: $listDataServicePart }";
}