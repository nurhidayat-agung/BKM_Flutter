part of 'replacement_part_history_bloc.dart';

abstract class ReplacementPartHistoryEvent extends Equatable {
  const ReplacementPartHistoryEvent();
}

class ReplacementPartHistory extends ReplacementPartHistoryEvent {
  final String itemId;

  const ReplacementPartHistory({
    required this.itemId
  });

  @override
  List<Object> get props => [itemId];

  @override
  String toString() => "PaySlip { itemId: $itemId }";
}