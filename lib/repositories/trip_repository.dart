import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';

class TripRepository {
  // =========================================================
  //                    GET LIST TRIP
  // =========================================================
  Future<http.Response> getTrip() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/trips"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/json",
        "Authorization": loginLocal[0].token,
        "User-ID": loginLocal[0].userId,
      },
    );

    return response;
  }

  // =========================================================
  //                GET TRIP DETAIL BY ID
  // =========================================================
  Future<http.Response> getTripDetail(String id) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/trip_detail/$id"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/json",
        "Authorization": loginLocal[0].token,
        "User-ID": loginLocal[0].userId,
      },
    );

    return response;
  }

  // =========================================================
  //                   UPDATE STATUS TRIP
  // =========================================================
  Future<String> updateTripStatus({
    required String tripId,
    required String status,
    String? tarra,
    String? bruto,
    String? netto,
    String? note,
    File? imageLoad,
    File? imageUnload,
  }) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${Constants.baseUrl}transaction/update_trip_status"),
    );

    // HEADER
    request.headers.addAll({
      "Client-Service": "driver-client",
      "Auth-Key": "bkmrestapi",
      "Authorization": loginLocal[0].token,
      "User-ID": loginLocal[0].userId,
    });

    // FIELDS
    request.fields["trip_id"] = tripId;
    request.fields["status_trip"] = status;

    if (tarra != null) request.fields["tarra"] = tarra;
    if (bruto != null) request.fields["bruto"] = bruto;
    if (netto != null) request.fields["netto"] = netto;

    if (note != null) {
      if (status == "loaded") {
        request.fields["note_load"] = note;
      } else if (status == "unloaded") {
        request.fields["note_unload"] = note;
      }
    }

    // IMAGE UPLOAD
    if (imageLoad != null) {
      request.files.add(
        http.MultipartFile(
          "img_spb_load",
          imageLoad.readAsBytes().asStream(),
          imageLoad.lengthSync(),
          filename: imageLoad.path.split("/").last,
        ),
      );
    }

    if (imageUnload != null) {
      request.files.add(
        http.MultipartFile(
          "img_spb_unload",
          imageUnload.readAsBytes().asStream(),
          imageUnload.lengthSync(),
          filename: imageUnload.path.split("/").last,
        ),
      );
    }

    var response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    return responseString;
  }

  // =========================================================
  //                     SAVE TRIP (QUBU)
  // =========================================================
  Future<String> saveTrip(
      String id,
      String statusTrip,
      String numberOfLoad,
      String numberOfUnload,
      String spbNo,
      String trigger,
      File? spbImg,
      ) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final uri = Uri.parse("${Constants.baseUrl}transaction/save_trip");

    var request = http.MultipartRequest("POST", uri);

    // HEADER
    request.headers.addAll({
      "Client-Service": "driver-client",
      "Auth-Key": "bkmrestapi",
      "Authorization": loginLocal[0].token,
      "User-ID": loginLocal[0].userId,
    });

    // FIELDS
    request.fields["id"] = id;
    request.fields["status_trip"] = statusTrip;
    request.fields["number_of_load"] = numberOfLoad;
    request.fields["number_of_unload"] = numberOfUnload;
    request.fields["spb_no"] = spbNo;
    request.fields["trigger"] = trigger;

    // FILE
    if (spbImg != null) {
      request.files.add(
        http.MultipartFile(
          "spb_img",
          spbImg.readAsBytes().asStream(),
          spbImg.lengthSync(),
          filename: spbImg.path.split("/").last,
        ),
      );
    }

    // SEND REQUEST
    final res = await request.send();
    final bytes = await res.stream.toBytes();
    return utf8.decode(bytes);
  }
}
