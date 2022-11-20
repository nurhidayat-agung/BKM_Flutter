import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class TripRepository {
  final _helper = APIBaseHelper();

  Future<Response> getTrip() async {
    Response response = await _helper.get("transaction/trips");

    return response;
  }

  Future<Response> getTripDetail(String id) async {
    Response response = await _helper.get("transaction/trip_detail/$id");

    return response;
  }

  Future<Response> saveTrip(String id, String statusTrip, String numberOfLoad, String numberOfUnload, String spbNo, String trigger, File spbImg) async {
    FormData formData = FormData.fromMap({
      "id": id,
      "status_trip": statusTrip,
      "number_of_load": numberOfLoad,
      "number_of_unload": numberOfUnload,
      "spb_no": spbNo,
      "trigger": trigger,
      "spb_img": await MultipartFile.fromFile(
        spbImg.path,
        filename: spbImg.path.split('/').last,
      ),
    });

    Response response = await _helper.post(
      "transaction/save_trips",
      formData: formData,
    );

    return response;
  }

}