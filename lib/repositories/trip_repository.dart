import 'dart:convert';
import 'dart:io';

import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/loading_location/loading_location_response.dart';
import 'package:newbkmmobile/models/new_trip/delivery_response.dart' show DeliveryResponse;
import 'package:newbkmmobile/models/new_trip/trip_detail_response.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';

class TripRepository {
  final HttpCommunicator _http = HttpCommunicator();

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
      spbImg.readAsBytes().asStream(),
      spbImg.lengthSync(),
      filename: spbImg.path.split("/").last,
    ));

    var response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    return responseString;
  }

  /// Ambil data delivery order baru berdasarkan driver ID
  /// Return tuple: (statusCode, DeliveryResponse?)
  /// Return tuple: (statusCode, DeliveryResponse?)
  /// Return tuple: (statusCode, DeliveryResponse?)
  Future<(int, DeliveryResponse?)> getNewDeliveryOrder() async {
    try {
      final driver = await SessionManager.getUserSession();

      if (driver == null) {
        print("Session tidak ditemukan. Login ulang.");
        return (401, null);
      }

      if (driver.driverId == null || driver.driverId!.isEmpty) {
        print("driverId kosong di Hive");
        return (400, null);
      }

      if (driver.token == null || driver.token!.isEmpty) {
        print("Token kosong di Hive");
        return (401, null);
      }

      final endpoint =
          "delivery-order-details/new?driver_id=${driver.driverId}";

      // Tambahkan header lengkap
      final httpResponse = await _http.get(
        endpoint,
        headers: {
          "X-Client-Type": "mobile",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${driver.token}",
        },
      );

      if (httpResponse.status == 200) {
        final resp = DeliveryResponse.fromJson(httpResponse.result);
        return (200, resp);
      }

      return (httpResponse.status, null);
    } catch (e) {
      print("Error fetching delivery order: $e");
      return (500, null);
    }
  }

  /// --------------------------------------------------------------------------
  /// GET delivery order detail by ID
  Future<(int, TripDetail?)> getDeliveryOrderDetail({
    required String id,
  }) async {
    try {
      final driver = await SessionManager.getUserSession();

      final headers = {
        'X-Site-ID': driver?.siteId ?? '',
        'Authorization': 'Bearer ${driver?.token ?? ''}',
      };

      final response = await _http.get('delivery-order-details/$id', headers: headers);

      if (response.result != null) {
        final tripDetail = TripDetailResponse.fromJson(response.result);
        return (response.status, tripDetail.data);
      } else {
        // Return status code tetap tapi data null
        return (response.status, null);
      }
    } catch (e) {
      throw Exception('Gagal fetch delivery order detail: $e');
    }
  }

  /// Terima delivery order
  /// [id] => ID delivery order detail
  Future<(int, dynamic)> acceptDeliveryOrder({
    required String id,
  }) async {
    final driver = await SessionManager.getUserSession();

    final endpoint = 'delivery-order-details/app/$id/accept';
    final headers = {
      'X-Site-ID': driver?.siteId ?? "",
      'Authorization': 'Bearer ${driver?.token ?? ""}',
    };

    try {
      final response = await _http.postJson(
        endpoint,
        body: {}, // body kosong sesuai curl
        headers: headers,
      );

      final statusCode = response.status; // ambil HTTP status code

      return (statusCode, response.result);
    } catch (e) {
      rethrow;
    }
  }



  Future<(int, dynamic)> loadingLocation({
    required String id,
    required String nextStatus,
    required String note
  }) async {
    try {
      final driver = await SessionManager.getUserSession();

      final headers = {
        'X-Site-ID': driver?.siteId ?? "",
        'Authorization': 'Bearer ${driver?.token ?? ""}',
      };

      final fields = {
        'next_status': nextStatus,
        'note': note,
      };

      final response = await _http.postFormData(
        'delivery-order-details/app/$id',
        fields: fields,
        headers: headers,
      );

      LoadingLocationResponse? parsedData;
      if (response.result != null) {
        parsedData = LoadingLocationResponse.fromJson(
            response.result as Map<String, dynamic>);
      }

      return (response.status, parsedData);
    } catch (e) {
      // Bisa lempar Exception atau return status error 0
      return (0,null);
    }
  }

}