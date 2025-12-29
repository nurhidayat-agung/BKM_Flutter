import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/langsir/local_hauling_data.dart';
import 'package:newbkmmobile/models/langsir_detail/local_hauling_detail_data.dart';
import 'package:newbkmmobile/models/langsir_detail_item/langsir_detail_item_response.dart';

abstract class LangsirState extends Equatable {
  const LangsirState();

  @override
  List<Object?> get props => [];
}

class LangsirInitial extends LangsirState {}

class LangsirLoading extends LangsirState {}

class LangsirListLoaded extends LangsirState {
  final List<LocalHaulingData> items;
  const LangsirListLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class LangsirDetailLoaded extends LangsirState {
  final LocalHaulingDetailData detail;
  const LangsirDetailLoaded(this.detail);

  @override
  List<Object?> get props => [detail];
}

class LangsirSuccess extends LangsirState {
  final String message;
  const LangsirSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LangsirFailure extends LangsirState {
  final String error;
  const LangsirFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LangsirSubmitSuccess extends LangsirState {
  final String message;

  const LangsirSubmitSuccess(this.message);
}

class LangsirSubmitFailed extends LangsirState {
  final String message;

  const LangsirSubmitFailed(this.message);
}

class FetchLangsirDetailItemSuccess extends LangsirState {
  final LangsirDetailItemResponse resp;

  const FetchLangsirDetailItemSuccess({
    required this.resp,
  });
}

class UpdateLangsirDetailItemSuccess extends LangsirState {
  final String message;

  const UpdateLangsirDetailItemSuccess({
    required this.message,
  });
}

class UpdateLangsirDetailItemFailure extends LangsirState {
  final String error;

  const UpdateLangsirDetailItemFailure(this.error);
}
