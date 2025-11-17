part of 'trip_detail_bloc.dart';

abstract class TripDetailState extends Equatable {
  const TripDetailState();
}

class TripDetailInitial extends TripDetailState {
  @override
  List<Object> get props => [];
}

class TripDetailLoading extends TripDetailState {
  const TripDetailLoading();
  @override
  List<Object> get props => [];
}

class TripDetailSuccess extends TripDetailState {
  final TripDetailResp tripDetailResp;
  const TripDetailSuccess(this.tripDetailResp);
  @override
  List<Object> get props => [tripDetailResp];
}

class TripDetailError extends TripDetailState {
  final String message;
  const TripDetailError(this.message);
  @override
  List<Object> get props => [message];
}
