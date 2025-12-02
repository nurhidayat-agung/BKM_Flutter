import 'package:newbkmmobile/models/trip_history/driver_history.dart';
import 'package:newbkmmobile/models/trip_history/vehicle_history.dart';

class DeliveryDetailHistory {
  String? id;
  String? doId;
  String? vehicleId;
  String? driverId;
  String? linkedDetailId;
  int? doNumber;
  int? prevDoNumber;
  int? loadQuantity;
  int? unloadQuantity;
  String? loadDate;
  String? unloadDate;
  int? loadTare;
  int? loadBruto;
  int? unloadTare;
  int? unloadBruto;
  String? status;
  String? latestStatusLog;
  String? spbNumber;
  int? shippingCost;
  String? qualityClaim;
  String? note;
  int? isIssued;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  VehicleHistory? vehicle;
  DriverHistory? driver;

  DeliveryDetailHistory({
    this.id,
    this.doId,
    this.vehicleId,
    this.driverId,
    this.linkedDetailId,
    this.doNumber,
    this.prevDoNumber,
    this.loadQuantity,
    this.unloadQuantity,
    this.loadDate,
    this.unloadDate,
    this.loadTare,
    this.loadBruto,
    this.unloadTare,
    this.unloadBruto,
    this.status,
    this.latestStatusLog,
    this.spbNumber,
    this.shippingCost,
    this.qualityClaim,
    this.note,
    this.isIssued,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.vehicle,
    this.driver,
  });

  factory DeliveryDetailHistory.fromJson(Map<String, dynamic> json) {
    return DeliveryDetailHistory(
      id: json['id'],
      doId: json['do_id'],
      vehicleId: json['vehicle_id'],
      driverId: json['driver_id'],
      linkedDetailId: json['linked_detail_id'],
      doNumber: json['do_number'],
      prevDoNumber: json['prev_do_number'],
      loadQuantity: json['load_quantity'],
      unloadQuantity: json['unload_quantity'],
      loadDate: json['load_date'],
      unloadDate: json['unload_date'],
      loadTare: json['load_tare'],
      loadBruto: json['load_bruto'],
      unloadTare: json['unload_tare'],
      unloadBruto: json['unload_bruto'],
      status: json['status'],
      latestStatusLog: json['latest_status_log'],
      spbNumber: json['spb_number'],
      shippingCost: json['shipping_cost'],
      qualityClaim: json['quality_claim'],
      note: json['note'],
      isIssued: json['is_issued'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      vehicle: json['vehicle'] != null ? VehicleHistory.fromJson(json['vehicle']) : null,
      driver: json['driver'] != null ? DriverHistory.fromJson(json['driver']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "do_id": doId,
      "vehicle_id": vehicleId,
      "driver_id": driverId,
      "linked_detail_id": linkedDetailId,
      "do_number": doNumber,
      "prev_do_number": prevDoNumber,
      "load_quantity": loadQuantity,
      "unload_quantity": unloadQuantity,
      "load_date": loadDate,
      "unload_date": unloadDate,
      "load_tare": loadTare,
      "load_bruto": loadBruto,
      "unload_tare": unloadTare,
      "unload_bruto": unloadBruto,
      "status": status,
      "latest_status_log": latestStatusLog,
      "spb_number": spbNumber,
      "shipping_cost": shippingCost,
      "quality_claim": qualityClaim,
      "note": note,
      "is_issued": isIssued,
      "is_active": isActive,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "deleted_by": deletedBy,
      "deleted_at": deletedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "vehicle": vehicle?.toJson(),
      "driver": driver?.toJson(),
    };
  }

}
