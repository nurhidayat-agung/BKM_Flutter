part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();
}

class GetTrip extends TripEvent {
  @override
  List<Object> get props => [];
}

class AcceptTrip extends TripEvent {
  final String deliveryOrderDetailId;

  const AcceptTrip({required this.deliveryOrderDetailId});

  @override
  List<Object> get props => [deliveryOrderDetailId];
}


class LoadingLocationTrip extends TripEvent {
  final String deliveryOrderDetailId;
  final String nextStatus;

  const LoadingLocationTrip({required this.deliveryOrderDetailId, required this.nextStatus});

  @override
  List<Object> get props => [deliveryOrderDetailId];
}
