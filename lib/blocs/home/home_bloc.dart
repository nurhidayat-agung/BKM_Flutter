// home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginRepository loginRepository;

  HomeBloc({required this.loginRepository}) : super(HomeInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(HomeLoading());
      try {
        final userSession = await SessionManager.getUserSession();

        if (userSession != null) {
          emit(HomeLoaded(
            name: userSession.name ?? '-',
            balance: userSession.balance ?? '0',
            savings: userSession.savings,
            heldAmmount: userSession.heldAmmount,
          ));
        } else {
          emit(const HomeError('User session tidak ditemukan.'));
        }
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
