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
  final List<DoDetailHistory> listHistoryResp;
  const HistorySuccess(this.listHistoryResp);
  @override
  List<Object> get props => [listHistoryResp];
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  List<Object> get props => [message];
}