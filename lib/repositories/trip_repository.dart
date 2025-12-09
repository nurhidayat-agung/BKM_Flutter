import 'dart:convert';
import 'dart:io';

import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/loading_location/loading_location_response.dart';
import 'package:newbkmmobile/models/trip/list_new_do_response.dart' show ListNewDoResponse;
import 'package:newbkmmobile/models/trip/show_do_response.dart';
import 'package:newbkmmobile/models/trip/v2/do_detail_response.dart';
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
  Future<(int, ListNewDoResponse?)> getNewDeliveryOrder() async {
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
        final resp = ListNewDoResponse.fromJson(httpResponse.result);
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
  Future<(int, DoDetailResponseData?)> getDeliveryOrderDetail({
    required String id,
  }) async {
    try {
      final driver = await SessionManager.getUserSession();

      final headers = {
        'X-Site-ID': driver?.siteId ?? '',
        'Authorization': 'Bearer ${driver?.token ?? ''}',
      };

      final response = await _http.get('delivery-order-details/app/$id', headers: headers);

      if (response.result != null) {
        final tripDetail = DoDetailResponse.fromJson(response.result);
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


  Future<(int, dynamic)> submitMuat({
    required String doDetailId,

    // DO utama
    required String spbNumber,
    required String loadTare,
    required String loadBruto,
    required String loadQuantity,
    File? imgSpbLoad,                   // FILE SPB

    // Common fields
    required String nextStatus,
    required String note,
    required bool isEdit,

    // DO sambung (opsional)
    String? spbNumberLink,
    String? loadTareLink,
    String? loadBrutoLink,
    String? loadQuantityLink,
  }) async {

    final driver = await SessionManager.getUserSession();

    // ============================
    //  FIELDS (tanpa file)
    // ============================
    final fields = <String, String>{
      "spb_number": spbNumber,
      "load_tare": loadTare,
      "load_bruto": loadBruto,
      "load_quantity": loadQuantity,
      "action_button": "load_save",
      "next_status": nextStatus,
      "note": note,
      "is_edit": isEdit ? "1" : "0",
    };

    // DO Sambung (optional)
    if (spbNumberLink != null) fields["spb_number_link"] = spbNumberLink;
    if (loadTareLink != null) fields["load_tare_link"] = loadTareLink;
    if (loadBrutoLink != null) fields["load_bruto_link"] = loadBrutoLink;
    if (loadQuantityLink != null) fields["load_quantity_link"] = loadQuantityLink;

    // ============================
    //  FILES (optional)
    // ============================
    final files = <String, File>{};
    if (imgSpbLoad != null) {
      files["img_spb_load"] = imgSpbLoad;
    }

    // ============================
    //  HEADERS
    // ============================
    final headers = {
      "Authorization": "Bearer ${driver?.token ?? ""}",
      "X-Site-ID": driver?.siteId ?? "",
    };

    var result = await _http.postFormData(
      "delivery-order-details/app/$doDetailId",
      fields: fields,
      files: files.isNotEmpty ? files : null,
      headers: headers,
    );

    return (result.status, result.result);
  }



  Future<(int, dynamic)> changeStatusTrip({
    required String id,
    required String nextStatus,
    required String note,
  }) async {
    try {
      final driver = await SessionManager.getUserSession();

      final headers = {
        'X-Site-ID': driver?.siteId ?? "",
        'Authorization': 'Bearer ${driver?.token ?? ""}',
      };

      // base fields
      final fields = {
        'next_status': nextStatus,
        'note': note,
      };

      // tambahan khusus nextStatus 7
      if (nextStatus == "7") {
        fields['action_button'] = "final_save";
      }

      final response = await _http.postFormData(
        'delivery-order-details/app/$id',
        fields: fields,
        headers: headers,
      );

      LoadingLocationResponse? parsedData;
      if (response.result != null) {
        parsedData = LoadingLocationResponse.fromJson(
          response.result as Map<String, dynamic>,
        );
      }

      return (response.status, parsedData);
    } catch (e) {
      return (0, null);
    }
  }



  Future<(int, dynamic)> submitBongkar({
    required String doDetailId,

    // DO utama
    required String unloadTare,
    required String unloadBruto,
    required String unloadQuantity,
    File? imgSpbLoad,                   // FILE SPB

    // Common fields
    required String nextStatus,
    required String note,
    required bool isEdit,

    // DO sambung (opsional)
    String? unloadTareLink,
    String? unloadBrutoLink,
    String? unloadQuantityLink,
  }) async {

    final driver = await SessionManager.getUserSession();

    // ============================
    //  FIELDS (tanpa file)
    // ============================
    final fields = <String, String>{
      "unload_tare": unloadTare,
      "unload_bruto": unloadBruto,
      "unload_quantity": unloadQuantity,
      "action_button": "unload_save",
      "next_status": nextStatus,
      "note": note,
      "is_edit": isEdit ? "1" : "0",
    };

    // DO Sambung (optional)
    if (unloadTareLink != null) fields["unload_tare_link"] = unloadTareLink;
    if (unloadBrutoLink != null) fields["unload_bruto_link"] = unloadBrutoLink;
    if (unloadQuantityLink != null) fields["unload_quantity_link"] = unloadQuantityLink;

    // ============================
    //  FILES (optional)
    // ============================
    final files = <String, File>{};
    if (imgSpbLoad != null) {
      files["img_spb_unload"] = imgSpbLoad;
    }

    // ============================
    //  HEADERS
    // ============================
    final headers = {
      "Authorization": "Bearer ${driver?.token ?? ""}",
      "X-Site-ID": driver?.siteId ?? "",
    };

    var result = await _http.postFormData(
      "delivery-order-details/app/$doDetailId",
      fields: fields,
      files: files.isNotEmpty ? files : null,
      headers: headers,
    );

    return (result.status, result.result);
  }

}