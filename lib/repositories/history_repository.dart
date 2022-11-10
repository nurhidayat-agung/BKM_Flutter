import 'package:dio/dio.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class HistoryRepository {
  final _helper = APIBaseHelper();

  Future<Response> getHistory() async {
    Response response = await _helper.get("transaction/histories");

    return response;
  }

  Future<Response> getHistoryDetail(int id) async {
    Response response = await _helper.get("transaction/histories/$id");

    return response;
  }

}