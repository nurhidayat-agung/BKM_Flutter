part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
  @override
  List<Object> get props => [];
}

class HistorySuccess extends HistoryState {
  final List<HistoryResp> listHistory;
  const HistorySuccess(this.listHistory);
  @override
  List<Object> get props => [listHistory];
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  List<Object> get props => [message];
}