import 'package:dio/dio.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class HistoryRepository {
  final _helper = APIBaseHelper();

  Future<Response> getHistory() async {
    Response response = await _helper.get("transaction/histories");

    return response;
  }

  Future<Response> getHistoryDetail(String id) async {
    Response response = await _helper.get("transaction/history_detail/$id");

    return response;
  }

}