part of 'save_trip_bloc.dart';

abstract class SaveTripState extends Equatable {
  const SaveTripState();
}

class SaveTripInitial extends SaveTripState {
  @override
  List<Object> get props => [];
}

class SaveTripLoading extends SaveTripState {
  const SaveTripLoading();
  @override
  List<Object> get props => [];
}

class SaveTripSuccess extends SaveTripState {
  final DebugResp debugResp;
  const SaveTripSuccess(this.debugResp);
  @override
  List<Object> get props => [DebugResp];
}

class SaveTripError extends SaveTripState {
  final String message;
  const SaveTripError(this.message);
  @override
  List<Object> get props => [message];
}
