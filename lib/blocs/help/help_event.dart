part of 'help_bloc.dart';

abstract class HelpEvent extends Equatable {
  const HelpEvent();
}

class Help extends HelpEvent {
  @override
  List<Object> get props => [];
}