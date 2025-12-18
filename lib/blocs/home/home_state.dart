// home_state.dart
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String name;
  final String balance;
  final String? savings;
  final String? heldAmmount;


  const HomeLoaded({required this.name, required this.balance, required this.savings, required this.heldAmmount});

  @override
  List<Object?> get props => [name, balance];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
