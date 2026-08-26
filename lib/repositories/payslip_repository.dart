import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/payslip/payslip_response_model.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';
import 'package:http/http.dart' as http;

class PaySlipRepository {
  final HttpCommunicator _httpCommunicator = HttpCommunicator();

  /// ===============================================================
  /// API BARU (QUBU API) - GET PAYSLIP BY PERIOD
  /// ===============================================================
  Future<(int, PayslipResponseModel?)> getPaySlipByPeriod(int month, int year) async {
    try {
      final session = await SessionManager.getUserSession();
      final driverId = session?.driverId ?? '';

      final headers = {
        'Accept': 'application/json',
        'X-Site-ID': session?.siteId ?? '',
        if (session?.token != null) 'Authorization': 'Bearer ${session!.token}',
      };

      final response = await _httpCommunicator.get(
        'payrolls/$driverId/payslip-by-period?month=$month&year=$year',
        headers: headers,
      );

      if (response.status == 200 && response.result != null) {
        final payslipResp = PayslipResponseModel.fromJson(response.result as Map<String, dynamic>);
        return (response.status, payslipResp);
      }

      String? errorMessage;
      if (response.result is Map<String, dynamic>) {
        errorMessage = response.result['message']?.toString();
      }

      return (
        response.status,
        PayslipResponseModel(
          status: 'error',
          message: errorMessage ?? 'Gagal mengambil data slip gaji (${response.status})',
        ),
      );
    } catch (e) {
      return (
        500,
        PayslipResponseModel(
          status: 'error',
          message: 'Terjadi kesalahan: $e',
        ),
      );
    }
  }

  /// ===============================================================
  /// API LAMA (LEGACY) - GET PAYSLIP
  /// ===============================================================
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