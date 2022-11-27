import 'package:dio/dio.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class PaySlipRepository {
  final _helper = APIBaseHelper();

  Future<Response> getPaySlip(int month, int year) async {
    Response response = await _helper.get("finance/payslip?month=$month&year=$year");

    return response;
  }

}