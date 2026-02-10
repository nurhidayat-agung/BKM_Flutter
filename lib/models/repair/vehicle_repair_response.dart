import 'package:newbkmmobile/models/repair/vehicle_repair_data.dart';

import 'maintenance_model.dart';

class VehicleRepairResponse {
  String? status;
  List<MaintenanceListData>? data;

  VehicleRepairResponse({this.status, this.data});

  factory VehicleRepairResponse.fromJson(Map<String, dynamic> json) =>
      VehicleRepairResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MaintenanceListData>.from(
            json["data"].map((x) => MaintenanceListData.fromJson(x))),
      );
}