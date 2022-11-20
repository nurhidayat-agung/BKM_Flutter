part of 'save_trip_bloc.dart';

abstract class SaveTripEvent extends Equatable {
  const SaveTripEvent();
}

class SaveTrip extends SaveTripEvent {
  final String id;
  final String statusTrip;
  final String numberOfLoad;
  final String numberOfUnload;
  final String spbNo;
  final String trigger;
  final File spbImg;

  const SaveTrip({
    required this.id,
    required this.statusTrip,
    required this.numberOfLoad,
    required this.numberOfUnload,
    required this.spbNo,
    required this.trigger,
    required this.spbImg,
  });

  @override
  List<Object> get props => [id, statusTrip, numberOfLoad, numberOfUnload, spbNo, trigger, spbImg];

  @override
  String toString() => "SaveTrip { id: $id, statusTrip: $statusTrip, numberOfLoad: $numberOfLoad, numberOfUnload: $numberOfUnload, spbNo: $spbNo, trigger: $trigger, spbImg: $spbImg }";
}