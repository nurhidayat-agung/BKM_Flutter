import 'dart:convert';
import 'dart:io';

import 'package:newbkmmobile/core/constants.dart';
import 'package:http/http.dart' as http;
import 'login_repository.dart';

class TripRepository {

  Future<http.Response> getTrip() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/trips"),
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

  Future<http.Response> getTripDetail(String id) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/trip_detail/$id"),
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

  Future<String> saveTrip(String id, String statusTrip, String numberOfLoad, String numberOfUnload, String spbNo, String trigger, File spbImg) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${Constants.baseUrl}transaction/save_trips"),
    );

    request.headers.addAll({
      "Client-Service": "driver-client",
      "Auth-Key": "bkmrestapi",
      "Content-Type": "multipart/form-data",
      "Authorization": loginLocal[0].token,
      "User-ID": loginLocal[0].userId,
    });

    request.fields['id']                = id;
    request.fields['status_trip']       = statusTrip;
    request.fields['number_of_load']    = numberOfLoad;
    request.fields['number_of_unload']  = numberOfUnload;
    request.fields['spb_no']            = spbNo;
    request.fields['trigger']           = trigger;

    request.files.add(http.MultipartFile(
        "spb_img",
        spbImg!.readAsBytes().asStream(),
        spbImg!.lengthSync(),
        filename: spbImg!.path.split("/").last,
    ));

    var response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    return responseString;
  }

}