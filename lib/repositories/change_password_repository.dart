import 'package:newbkmmobile/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/repositories/login_repository.dart';

class ChangePasswordRepository {

  Future<http.Response> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    var map = <String, dynamic>{};
    map['password'] = oldPassword;
    map['password_new'] = newPassword;
    map['password_confirm'] = confirmPassword;

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}auth/change_password"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": loginLocal[0].token,
        "User-ID": loginLocal[0].userId,
      },
      body: map,
    );

    return response;
  }

}