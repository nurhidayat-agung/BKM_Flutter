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
  final bool isEdit;

  const PushMuat({required this.deliveryData, required this.tripDetail, required this.muatRequest, required this.isEdit});

  @override
  List<Object> get props => [deliveryData, tripDetail, muatRequest];
}

class PushBongkar extends TripEvent {
  final DeliveryData deliveryData;
  final TripDetail tripDetail;
  final LoadUnloadRequest bongkarRequest;
  final bool isEdit;

  const PushBongkar({required this.deliveryData, required this.tripDetail, required this.bongkarRequest, required this.isEdit});

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
