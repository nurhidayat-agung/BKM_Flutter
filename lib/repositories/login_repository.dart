import 'package:dio/dio.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class LoginRepository {
  final _helper = APIBaseHelper();

  Future<Response> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      "username": username,
      "password": password,
    });

    Response response = await _helper.post(
      "auth/login",
      formData: formData,
    );

    return response;
  }

  Future<Response> userDetail() async {
    Response response = await _helper.get("transaction/user_info");

    return response;
  }

}