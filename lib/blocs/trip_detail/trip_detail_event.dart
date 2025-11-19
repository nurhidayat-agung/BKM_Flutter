part of 'trip_detail_bloc.dart';

abstract class TripDetailEvent extends Equatable {
  const TripDetailEvent();
}

class TripDetailDataEvent extends TripDetailEvent {
  final String id;

  const TripDetailDataEvent({
    required this.id
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => "TripDetail { id: $id }";
}
