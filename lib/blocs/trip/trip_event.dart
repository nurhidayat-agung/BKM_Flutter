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


class PushMuat extends TripEvent {
  final DeliveryData deliveryData;
  final TripDetail tripDetail;
  final LoadUnloadRequest muatRequest;

  const PushMuat({required this.deliveryData, required this.tripDetail, required this.muatRequest});

  @override
  List<Object> get props => [deliveryData, tripDetail, muatRequest];
}

class PushBongkar extends TripEvent {
  final DeliveryData deliveryData;
  final TripDetail tripDetail;
  final LoadUnloadRequest bongkarRequest;

  const PushBongkar({required this.deliveryData, required this.tripDetail, required this.bongkarRequest});

  @override
  List<Object> get props => [deliveryData, tripDetail, bongkarRequest];
}

class PushTripUnload extends TripEvent {
  final DeliveryData deliveryData;
  final TripDetail tripDetail;

  const PushTripUnload({required this.deliveryData, required this.tripDetail});

  @override
  List<Object> get props => [deliveryData, tripDetail];
}

class PushTillUnload extends TripEvent {
  final DeliveryData deliveryData;
  final TripDetail tripDetail;

  const PushTillUnload({required this.deliveryData, required this.tripDetail});

  @override
  List<Object> get props => [deliveryData, tripDetail];
}
