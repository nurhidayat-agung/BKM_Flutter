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

}