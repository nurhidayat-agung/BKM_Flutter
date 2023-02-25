part of 'help_bloc.dart';

abstract class HelpState extends Equatable {
  const HelpState();
}

class HelpInitial extends HelpState {
  @override
  List<Object> get props => [];
}

class HelpLoading extends HelpState {
  const HelpLoading();
  @override
  List<Object> get props => [];
}

class HelpSuccess extends HelpState {
  final List<HelpResp> listHelpResp;
  const HelpSuccess(this.listHelpResp);
  @override
  List<Object> get props => [listHelpResp];
}

class HelpError extends HelpState {
  final String message;
  const HelpError(this.message);
  @override
  List<Object> get props => [message];
}