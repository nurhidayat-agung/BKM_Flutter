import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

class WorkshopRepository {

  Future<http.Response> getQueue(String driverId) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}workshops/queue"),
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

  Future<http.Response> getWaitingList() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}workshops/waiting_list"),
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

  Future<http.Response> getHistory() async {
    final loginLocal = await LoginRepository().getLoginLocal();
    final userDetailLocal = await UserDetailRepository().getUserDetailLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}workshops/history?driver_id=${userDetailLocal[0].driverId}"),
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

  Future<http.Response> cancelRegister(String id) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}workshops/cancel$id"),
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

  Future<http.Response> registerWorkshop(String reason) async {
    final loginLocal = await LoginRepository().getLoginLocal();
    final userDetailLocal = await UserDetailRepository().getUserDetailLocal();

    var map           = <String, dynamic>{};
    map['driver_id']  = userDetailLocal[0].driverId;
    map['vehicle_id'] = userDetailLocal[0].vehicle.id;
    map['reason']     = reason;

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}workshops/register"),
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