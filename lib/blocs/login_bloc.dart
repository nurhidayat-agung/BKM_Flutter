import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newbkmmobile/models/login_resp.dart';
import 'package:newbkmmobile/models/user_detail_resp.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final UserDetailRepository _userDetailRepository;

  LoginBloc(
      this._loginRepository,
      this._userDetailRepository,
  ) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        try {
          emit(const LoginLoading());
          final responseLogin = await _loginRepository.login(event.username, event.password);
          final resultLogin = LoginResp.fromJson(responseLogin.data);
          await _loginRepository.addLoginLocal(resultLogin.toLocal());

          final responseUserDetail = await _userDetailRepository.getUserDetailRemote();
          final resultUserDetail = UserDetailResp.fromJson(responseUserDetail.data);
          await _userDetailRepository.addUserDetailLocal(resultUserDetail.toLocal());
          emit(LoginSuccess(resultLogin));
        } catch (e) {
          emit(LoginError(e.toString()));
        }
      }
    });
  }

}
