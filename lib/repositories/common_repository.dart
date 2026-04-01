import 'package:newbkmmobile/services/http_communicator.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:flutter/foundation.dart';

class CommonRepository {
  /// mengambil data dari API 'common'
  Future<Map<String, dynamic>> getCommonData() async {
    try {
      final driver = await SessionManager.getUserSession();
      final headers = {
        'Accept': 'application/json',
        'X-Site-ID': driver?.siteId ?? "",
        'Authorization': 'Bearer ${driver?.token ?? ""}',
        'X-Client-Type': 'mobile',
      };

      // Tembak API
      final response = await HttpCommunicator().get('initial-data', headers: headers);

      return {
        'status': response.status,
        'result': response.result,
      };
    } catch (e) {
      debugPrint("Error CommonRepository: $e");
      return {
        'status': 500,
        'result': null,
      };
    }
  }
}