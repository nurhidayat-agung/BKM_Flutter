part of 'trip_detail_bloc.dart';

abstract class TripDetailEvent extends Equatable {
  const TripDetailEvent();
}

class TripDetail extends TripDetailEvent {
  final String id;

  const TripDetail({
    required this.id
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => "TripDetail { id: $id }";
}
