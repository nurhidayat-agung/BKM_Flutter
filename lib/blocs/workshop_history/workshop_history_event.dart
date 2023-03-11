part of 'workshop_history_bloc.dart';

abstract class WorkshopHistoryEvent extends Equatable {
  const WorkshopHistoryEvent();
}

class WorkshopHistory extends WorkshopHistoryEvent {
  @override
  List<Object> get props => [];
}