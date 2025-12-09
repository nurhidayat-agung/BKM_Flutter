import 'package:newbkmmobile/models/repair/repair_type.dart';
import 'package:newbkmmobile/models/repair/user_data.dart';
import 'package:newbkmmobile/models/repair/vehicle_data.dart';

class VehicleRepairData {
  String? id;
  String? userId;
  String? vehicleId;
  String? requestDate;
  int? currentKm;
  String? repairTypeId;
  String? damageDescription;
  String? urgencyLevelId;
  String? status;
  String? approvedBy;
  String? approvedAt;
  String? completedAt;
  int? repairCost;
  String? completionNote;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  UserData? user;
  VehicleData? vehicle;
  RepairType? repairType;
  UrgencyLevel? urgencyLevel;

  VehicleRepairData({
    this.id,
    this.userId,
    this.vehicleId,
    this.requestDate,
    this.currentKm,
    this.repairTypeId,
    this.damageDescription,
    this.urgencyLevelId,
    this.status,
    this.approvedBy,
    this.approvedAt,
    this.completedAt,
    this.repairCost,
    this.completionNote,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.vehicle,
    this.repairType,
    this.urgencyLevel,
  });

  factory VehicleRepairData.fromJson(Map<String, dynamic> json) =>
      VehicleRepairData(
        id: json["id"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        requestDate: json["request_date"],
        currentKm: json["current_km"],
        repairTypeId: json["repair_type_id"],
        damageDescription: json["damage_description"],
        urgencyLevelId: json["urgency_level_id"],
        status: json["status"],
        approvedBy: json["approved_by"],
        approvedAt: json["approved_at"],
        completedAt: json["completed_at"],
        repairCost: json["repair_cost"],
        completionNote: json["completion_note"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        vehicle:
        json["vehicle"] == null ? null : VehicleData.fromJson(json["vehicle"]),
        repairType: json["repair_type"] == null
            ? null
            : RepairType.fromJson(json["repair_type"]),
        urgencyLevel: json["urgency_level"] == null
            ? null
            : UrgencyLevel.fromJson(json["urgency_level"]),
      );
}