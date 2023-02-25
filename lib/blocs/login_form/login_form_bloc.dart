import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/login_form_local.dart';
import 'package:newbkmmobile/repositories/login_form_repository.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final LoginFormRepository _loginFormRepository;
  
  LoginFormBloc(this._loginFormRepository) : super(LoginFormInitial()) {
    on<LoginFormEvent>((event, emit) async {
      if (event is LoginForm) {
        try {
          emit(const LoginFormLoading());
          final response = await _loginFormRepository.getLoginFormLocal();
          emit(LoginFormSuccess(response));
        } catch (e) {
          emit(LoginFormError(e.toString()));
        }
      }
    });
  }

}
