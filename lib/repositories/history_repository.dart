import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:http/http.dart' as http;

class HistoryRepository {

  Future<http.Response> getHistory() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final driverId = loginLocal[0].driverId ?? "";
    final siteId = loginLocal[0].siteId ?? "";

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}api/delivery-order-details/completed?driver_id=$driverId"),
      headers: {
        "Accept": "application/json",
        "X-Site-ID": siteId,
        "Authorization": "Bearer ${loginLocal[0].token}",
      },
    );
    return response;
  }

  Future<http.Response> getHistoryDetail(String id) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final siteId = loginLocal[0].siteId ?? "";

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}api/delivery-order-details/$id"),
      headers: {
        "Accept": "application/json",
        "X-Site-ID": siteId,
        "Authorization": "Bearer ${loginLocal[0].token}",
      },
    );

    return response;
  }
}
