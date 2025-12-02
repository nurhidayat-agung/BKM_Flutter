import 'package:equatable/equatable.dart';

abstract class LangsirState extends Equatable {
  const LangsirState();

  @override
  List<Object?> get props => [];
}

class LangsirInitial extends LangsirState {}

class LangsirLoading extends LangsirState {}

class LangsirListLoaded extends LangsirState {
  final List<Map<String, dynamic>> items;
  const LangsirListLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class LangsirDetailLoaded extends LangsirState {
  final Map<String, dynamic> detail;
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
