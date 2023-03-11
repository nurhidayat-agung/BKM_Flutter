part of 'workshop_history_bloc.dart';

abstract class WorkshopHistoryState extends Equatable {
  const WorkshopHistoryState();
}

class WorkshopHistoryInitial extends WorkshopHistoryState {
  @override
  List<Object> get props => [];
}

class WorkshopHistoryLoading extends WorkshopHistoryState {
  @override
  List<Object> get props => [];
}

class WorkshopHistorySuccess extends WorkshopHistoryState {
  final List<DataHistoryWorkshop> listDataHistoryWorkshop;
  const WorkshopHistorySuccess(this.listDataHistoryWorkshop);
  @override
  List<Object> get props => [listDataHistoryWorkshop];
}

class WorkshopHistoryError extends WorkshopHistoryState {
  final String message;
  const WorkshopHistoryError(this.message);
  @override
  List<Object> get props => [message];
}