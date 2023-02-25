import 'package:newbkmmobile/core/constants.dart';
import 'package:http/http.dart' as http;
import 'login_repository.dart';

class HistoryRepository {

  Future<http.Response> getHistory() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/histories"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": loginLocal[0].token,
        "User-ID": loginLocal[0].userId,
      },
    );

    return response;
  }

  Future<http.Response> getHistoryDetail(String id) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/history_detail/$id"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": loginLocal[0].token,
        "User-ID": loginLocal[0].userId,
      },
    );

    return response;
  }

}