part of 'history_detail_bloc.dart';

abstract class HistoryDetailEvent extends Equatable {
  const HistoryDetailEvent();
}

class HistoryDetail extends HistoryDetailEvent {
  final String id;

  const HistoryDetail({
    required this.id
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => "HistoryDetail { username: $id }";
}