import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:http/http.dart' as http;

class PaySlipRepository {

  Future<http.Response> getPaySlip(int month, int year) async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}finance/payslip?month=$month&year=$year"),
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

}