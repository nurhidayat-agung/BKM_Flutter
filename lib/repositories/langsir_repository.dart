import 'dart:io';

import 'package:newbkmmobile/models/login/UserSession.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';

class LangsirRepository {
  Future<List<Map<String, dynamic>>> fetchList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {"id": "1", "do": "051/KAL-EUP/IP-CPO/X/2025", "tanggal": "11 Nov 2025", "route": "SAM1 → ASK | CPO"},
      {"id": "2", "do": "052/KAL-EUP/IP-CPO/X/2025", "tanggal": "11 Nov 2025", "route": "SAM1 → ASK | CPO"},
      {"id": "3", "do": "053/KAL-EUP/IP-CPO/X/2025", "tanggal": "12 Nov 2025", "route": "SAM1 → ASK | CPO"},
    ];
  }

  /// ===========================================================
  /// GET OPEN LOCAL HAULING (DELIVERY ORDERS)
  /// ===========================================================
  /// Behavior:
  /// - Sama seperti updateRepair
  /// - Return (statusCode, rawResponse)
  /// - Parsing model dilakukan di layer atas (Bloc / Cubit)
  ///
  Future<(int, dynamic)> getOpenLocalHauling({
    bool isTransshipment = true,
  }) async {
    try {
      final UserSession? session = await SessionManager.getUserSession();

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Client-Type': 'mobile',
        'X-Site-ID': session?.siteId ?? "",
        if (session?.token != null)
          'Authorization': 'Bearer ${session!.token}',
      };

      final response = await HttpCommunicator().getJson(
        'delivery-orders/open',
        headers: headers,
        body: {
          'is_transshipment': isTransshipment,
        },
      );

      /// RETURN SESUAI REQUEST (status, response.result)
      return (response.status, response.result);

    } catch (e) {
      /// ERROR GLOBAL
      return (500, {
        'message': 'Failed get local hauling data',
        'error': e.toString(),
      });
    }
  }

  Future<Map<String, dynamic>> fetchDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "id": id,
      "do": "051/KAL-EUP/IP-CPO/X/2025",
      "route": "SAM1 → ASK | CPO",
      "tanggal": "11 Nov 2025",
      "muat": [
        {"no": 1, "jumlah": 27000, "tanggal": "13 Nov 2025"},
        {"no": 2, "jumlah": 27000, "tanggal": "13 Nov 2025"},
      ],
      "bongkar": [
        {"no": 1, "jumlah": 2000, "tanggal": "13 Nov 2025"}
      ]
    };
  }

  Future<String> saveMuat(
      String id,
      String jumlah,
      String tanggal,
      String action,
      File? photoMuat,
      ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // DEBUG Simulasi upload foto
    print(">> Foto muat: ${photoMuat?.path}");
    return action == "partial_save" ? "Muat disimpan sementara" : "Muat terselesaikan";
  }

  Future<String> saveBongkar(
      String id,
      String jumlah,
      String tanggal,
      String action,
      File? photoBongkar,
      ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print(">> Foto bongkar: ${photoBongkar?.path}");
    return action == "partial_save" ? "Bongkar disimpan sementara" : "Bongkar terselesaikan";
  }


}
