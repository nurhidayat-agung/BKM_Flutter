part of 'history_detail_bloc.dart';

abstract class HistoryDetailState extends Equatable {
  const HistoryDetailState();
}

class HistoryDetailInitial extends HistoryDetailState {
  @override
  List<Object> get props => [];
}

class HistoryDetailLoading extends HistoryDetailState {
  const HistoryDetailLoading();
  @override
  List<Object> get props => [];
}

class HistoryDetailSuccess extends HistoryDetailState {
  final HistoryDetailResp historyDetailResp;
  const HistoryDetailSuccess(this.historyDetailResp);
  @override
  List<Object> get props => [HistoryDetailResp];
}

class HistoryDetailError extends HistoryDetailState {
  final String message;
  const HistoryDetailError(this.message);
  @override
  List<Object> get props => [message];
}
