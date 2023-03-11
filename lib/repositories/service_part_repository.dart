import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:http/http.dart' as http;

class ServicePartRepository {

  Future<http.Response> getServicePart() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}book_service/list_sparepart"),
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

  Future<http.Response> getReplacementPartHistory(String itemId) async {
    final loginLocal = await LoginRepository().getLoginLocal();
    final userDetailLocal = await UserDetailRepository().getUserDetailLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}book_service/replacement_sparepart?vehicle=${userDetailLocal[0].vehicle.id}&&item=$itemId"),
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