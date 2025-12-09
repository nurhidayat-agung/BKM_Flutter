import 'package:newbkmmobile/models/repair/vehicle_repair_data.dart';

class VehicleRepairResponse {
  String? status;
  List<VehicleRepairData>? data;

  VehicleRepairResponse({this.status, this.data});

  factory VehicleRepairResponse.fromJson(Map<String, dynamic> json) =>
      VehicleRepairResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<VehicleRepairData>.from(
            json["data"].map((x) => VehicleRepairData.fromJson(x))),
      );
}