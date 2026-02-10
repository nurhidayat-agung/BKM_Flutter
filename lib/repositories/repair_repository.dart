import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/models/repair/repair_model.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';

class RepairRepository {
  final ConvertDate _dateConverter = ConvertDate();

  // Data Dummy Static .
  static final List<RepairModel> _dummyData = [
    RepairModel(
      id: '1',
      urgencyTitle: 'Medium',
      date: '10 Nov 2025',
      repairType: 'Mesin',
      lastKm: '3.000 Km',
      status: 'Disetujui',
      statusColor: const Color(0xFF4CAF50),
      description: 'Perbaikan rutin pada bagian mesin utama.',
    ),
    RepairModel(
      id: '2',
      urgencyTitle: 'Medium',
      date: '10 Nov 2025',
      repairType: 'Mesin',
      lastKm: '3.000 Km',
      status: 'Ditunda',
      statusColor: const Color(0xFFFDD835),
      description: 'Menunggu ketersediaan sparepart.',
    ),
    RepairModel(
      id: '3',
      urgencyTitle: 'Medium',
      date: '10 Nov 2025',
      repairType: 'Mesin',
      lastKm: '3.000 Km',
      status: 'Ditolak',
      statusColor: const Color(0xFFE53935),
      description: 'Kerusakan dianggap kelalaian pengemudi.',
    ),
    RepairModel(
      id: '4',
      urgencyTitle: 'Medium',
      date: '10 Nov 2025',
      repairType: 'Mesin',
      lastKm: '3.000 Km',
      status: 'Proses',
      statusColor: const Color(0xFF1976D2),
      description: 'Sedang dalam pengerjaan di bengkel rekanan.',
    ),
    RepairModel(
      id: '5',
      urgencyTitle: 'Medium',
      date: '10 Nov 2025',
      repairType: 'Mesin',
      lastKm: '3.000 Km',
      status: 'Selesai',
      statusColor: const Color(0xFFFF9800),
      description: 'Perbaikan selesai, unit siap jalan.',
    ),
  ];

  // Mengambil data (Get)
  Future<List<RepairModel>> getRepairs() async {
    // Simulasi Delay API
    await Future.delayed(const Duration(seconds: 1));

    // Mengembalikan list yang ada di memori
    return _dummyData;
  }

  // Menyimpan data baru (Post/Store)
  Future<(int, dynamic)> submitRepair({
    required String type,
    required String urgency,
    required List<String> listRepair,
    required String lastKm,
    required String description,
  }) async {
    final session = await SessionManager.getUserSession();

    final headers = {
      'X-Client-Type': 'mobile',
      if (session?.token != null)
        'Authorization': 'Bearer ${session!.token}',
      'X-Site-ID' : session?.siteId ?? ''
    };

    final response = await HttpCommunicator().postJson(
      'maintenance-requests',
      headers: headers,
      body: {
        'requested_by': session?.driverId ?? '',
        'vehicle_id': session?.vehicleId ?? '',
        'maintenance_type_id': type,
        'damage_ids' : listRepair,
        'priority': urgency,
        'current_km': int.tryParse(lastKm) ?? 0,
        'request_at': _dateConverter.getDateToday(format: "yyyy-MM-dd"), // yyyy-MM-dd
        'description': description
      },
    );

    /// RETURN SESUAI REQUEST KAMU
    return (response.status, response.result);
  }

  Future<(int, dynamic)> updateRepair({
    required String id,
    required String type,
    required String urgency,
    required String lastKm,
    required String description,
    required List<String> listRepair,
  }) async {
    final session = await SessionManager.getUserSession();

    final headers = {
      'X-Client-Type': 'mobile',
      if (session?.token != null)
        'Authorization': 'Bearer ${session!.token}',
    };

    final response = await HttpCommunicator().putJson(
      'maintenance-requests/$id',
      headers: headers,
      body: {
        'requested_by': session?.driverId ?? '',
        'vehicle_id': session?.vehicleId ?? '',
        'maintenance_type_id': type,
        'priority': urgency,
        'current_km': int.tryParse(lastKm) ?? 0,
        'description': description,
        'damage_ids': listRepair,
        'request_date': _dateConverter.getDateToday(format: "yyyy-MM-dd"),
      },
    );

    /// RETURN SESUAI REQUEST KAMU
    return (response.status, response.result);
  }



  // Helper function untuk format tanggal
  String _getTodayDate() {
    final now = DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return "${now.day} ${months[now.month - 1]} ${now.year}";
  }


  Future<(int, dynamic)> getVehicleRepairsByUser() async {
    final driver = await SessionManager.getUserSession();

    final userId = driver?.driverId ?? ""; // sesuai sub: di token userID
    final endpoint = 'maintenance-requests/?requested_by=$userId';

    final headers = {
      'X-Site-ID': driver?.siteId ?? "",
      'Authorization': 'Bearer ${driver?.token ?? ""}',
    };

    final response = await HttpCommunicator().get(endpoint, headers: headers);

    return (response.status, response.result);
  }

}