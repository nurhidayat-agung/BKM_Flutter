import 'package:newbkmmobile/models/trip_history/v2/delivery_order_history.dart';

import 'driver_history.dart';
import 'vehicle_history.dart';
import 'status_model_history.dart';
import 'trip_allowance_history.dart';
import 'wallet_transaction_history.dart';
import 'linked_detail_history.dart';
import 'file_model_history.dart';

class DoDetailHistory {
  final String? id;
  final String? doId;
  final String? vehicleId;
  final String? driverId;
  final String? linkedDetailId;
  final int? doNumber;
  final int? prevDoNumber;
  final num? loadQuantity;
  final num? unloadQuantity;
  final String? loadDate;
  final String? unloadDate;
  final num? loadTare;
  final num? loadBruto;
  final num? unloadTare;
  final num? unloadBruto;
  final StatusModelHistory? status;
  final String? latestStatusLog;
  final String? spbNumber;
  final num? shippingCost;
  final dynamic qualityClaim;
  final String? note;
  final int? isIssued;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final DriverHistory? driver;
  final VehicleHistory? vehicle;
  final LinkedDetailHistory? linkedDetail;
  final TripAllowanceHistory? tripAllowance;
  final WalletTransactionHistory? walletTransaction;
  final List<FileModelHistory> files;
  final DeliveryOrderHistory? deliveryOrder;

  DoDetailHistory({
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
    this.driver,
    this.vehicle,
    this.linkedDetail,
    this.tripAllowance,
    this.walletTransaction,
    this.deliveryOrder,
    this.files = const [],
  });

  factory DoDetailHistory.fromJson(Map<String, dynamic> json) {
    return DoDetailHistory(
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
      status: json['status'] is Map ? StatusModelHistory.fromJson(json['status']) : null,
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
      driver: json['driver'] != null ? DriverHistory.fromJson(json['driver']) : null,
      vehicle: json['vehicle'] != null ? VehicleHistory.fromJson(json['vehicle']) : null,
      linkedDetail: json['linked_detail'] != null
          ? LinkedDetailHistory.fromJson(json['linked_detail'])
          : null,
      tripAllowance: json['trip_allowance'] != null
          ? TripAllowanceHistory.fromJson(json['trip_allowance'])
          : null,
      walletTransaction: json['wallet_transaction'] != null
          ? WalletTransactionHistory.fromJson(json['wallet_transaction'])
          : null,
      files: json['files'] != null
          ? List<FileModelHistory>.from(
        json['files'].map((x) => FileModelHistory.fromJson(x)),
      )
          : [],
      deliveryOrder: json['delivery_order'] != null
          ? DeliveryOrderHistory.fromJson(json['delivery_order'])
          : null,
    );
  }
}
