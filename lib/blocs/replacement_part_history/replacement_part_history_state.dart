part of 'replacement_part_history_bloc.dart';

abstract class ReplacementPartHistoryState extends Equatable {
  const ReplacementPartHistoryState();
}

class ReplacementPartHistoryInitial extends ReplacementPartHistoryState {
  @override
  List<Object> get props => [];
}

class ReplacementPartHistoryLoading extends ReplacementPartHistoryState {
  const ReplacementPartHistoryLoading();
  @override
  List<Object> get props => [];
}

class ReplacementPartHistorySuccess extends ReplacementPartHistoryState {
  final List<DataReplacementPartHistory> listDataReplacementPartHistory;
  const ReplacementPartHistorySuccess(this.listDataReplacementPartHistory);
  @override
  List<Object> get props => [listDataReplacementPartHistory];
}

class ReplacementPartHistoryError extends ReplacementPartHistoryState {
  final String message;
  const ReplacementPartHistoryError(this.message);
  @override
  List<Object> get props => [message];
}