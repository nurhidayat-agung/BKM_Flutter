part of 'workshop_waiting_list_bloc.dart';

abstract class WorkshopWaitingListState extends Equatable {
  const WorkshopWaitingListState();
}

class WorkshopWaitingListInitial extends WorkshopWaitingListState {
  @override
  List<Object> get props => [];
}

class WorkshopWaitingListLoading extends WorkshopWaitingListState {
  @override
  List<Object> get props => [];
}

class WorkshopWaitingListSuccess extends WorkshopWaitingListState {
  final List<DataHistoryWaitingList> listDataHistoryWaitingList;
  const WorkshopWaitingListSuccess(this.listDataHistoryWaitingList);
  @override
  List<Object> get props => [listDataHistoryWaitingList];
}

class WorkshopWaitingListError extends WorkshopWaitingListState {
  final String message;
  const WorkshopWaitingListError(this.message);
  @override
  List<Object> get props => [message];
}