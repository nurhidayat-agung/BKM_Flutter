import 'package:newbkmmobile/core/constants.dart';
import 'package:http/http.dart' as http;
import 'login_repository.dart';
import 'user_detail_repository.dart';

class ServiceBookRepository {

  Future<http.Response> getServiceBook() async {
    final loginLocal = await LoginRepository().getLoginLocal();
    final userDetailLocal = await UserDetailRepository().getUserDetailLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}book_service?vehicle_id=${userDetailLocal[0].vehicle.id}"),
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