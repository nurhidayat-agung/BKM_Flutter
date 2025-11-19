import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/repositories/session_manager_repository.dart';

import '../services/http_communicator.dart';

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

  Future<(int, dynamic)> getCompletedDeliveryOrders() async {
    final driver = await SessionManager.getUserSession();

    final endpoint = 'delivery-order-details/completed?driver_id=${driver?.driverId}';
    final headers = {
      'X-Site-ID': driver?.siteId ?? "",
      'Authorization': 'Bearer ${driver?.token ?? ""}',
    };

    final response = await HttpCommunicator().get(endpoint, headers: headers);

    return (response.status, response);
  }

}
