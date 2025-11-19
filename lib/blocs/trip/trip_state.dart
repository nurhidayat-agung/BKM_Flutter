part of 'trip_bloc.dart';

abstract class TripState extends Equatable {
  const TripState();
}

class TripInitial extends TripState {
  @override
  List<Object> get props => [];
}

class TripLoading extends TripState {
  const TripLoading();
  @override
  List<Object> get props => [];
}

class TripSuccess extends TripState with EquatableMixin {
  final TripDetail tripDetail;
  final DeliveryData deliveryData;

  TripSuccess({required this.tripDetail, required this.deliveryData});

  @override
  List<Object> get props => [tripDetail, deliveryData];
}




class TripError extends TripState {
  final String message;
  const TripError(this.message);
  @override
  List<Object> get props => [message];
}
