import 'dart:convert';

class LoadingLocationResponse {
  final String? status;
  final String? message;
  final LoadingLocation? data;

  LoadingLocationResponse({this.status, this.message, this.data});

  factory LoadingLocationResponse.fromJson(Map<String, dynamic> json) {
    return LoadingLocationResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? LoadingLocation.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class LoadingLocation {
  final String? id;
  final String? doId;
  final String? vehicleId;
  final String? driverId;
  final String? linkedDetailId;
  final int? doNumber;
  final int? prevDoNumber;
  final int? loadQuantity;
  final int? unloadQuantity;
  final String? loadDate;
  final String? unloadDate;
  final int? loadTare;
  final int? loadBruto;
  final int? unloadTare;
  final int? unloadBruto;
  final String? status;
  final String? latestStatusLog;
  final String? spbNumber;
  final int? shippingCost;
  final String? qualityClaim;
  final String? note;
  final int? isIssued;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final DeliveryOrder? deliveryOrder;

  LoadingLocation({
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
    this.deliveryOrder,
  });

  factory LoadingLocation.fromJson(Map<String, dynamic> json) {
    return LoadingLocation(
      id: json['id'] as String?,
      doId: json['do_id'] as String?,
      vehicleId: json['vehicle_id'] as String?,
      driverId: json['driver_id'] as String?,
      linkedDetailId: json['linked_detail_id'] as String?,
      doNumber: json['do_number'] as int?,
      prevDoNumber: json['prev_do_number'] as int?,
      loadQuantity: json['load_quantity'] as int?,
      unloadQuantity: json['unload_quantity'] as int?,
      loadDate: json['load_date'] as String?,
      unloadDate: json['unload_date'] as String?,
      loadTare: json['load_tare'] as int?,
      loadBruto: json['load_bruto'] as int?,
      unloadTare: json['unload_tare'] as int?,
      unloadBruto: json['unload_bruto'] as int?,
      status: json['status'] as String?,
      latestStatusLog: json['latest_status_log'] as String?,
      spbNumber: json['spb_number'] as String?,
      shippingCost: json['shipping_cost'] as int?,
      qualityClaim: json['quality_claim'] as String?,
      note: json['note'] as String?,
      isIssued: json['is_issued'] as int?,
      isActive: json['is_active'] as int?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      deletedBy: json['deleted_by'] as String?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deliveryOrder: json['delivery_order'] != null
          ? DeliveryOrder.fromJson(
          json['delivery_order'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'do_id': doId,
    'vehicle_id': vehicleId,
    'driver_id': driverId,
    'linked_detail_id': linkedDetailId,
    'do_number': doNumber,
    'prev_do_number': prevDoNumber,
    'load_quantity': loadQuantity,
    'unload_quantity': unloadQuantity,
    'load_date': loadDate,
    'unload_date': unloadDate,
    'load_tare': loadTare,
    'load_bruto': loadBruto,
    'unload_tare': unloadTare,
    'unload_bruto': unloadBruto,
    'status': status,
    'latest_status_log': latestStatusLog,
    'spb_number': spbNumber,
    'shipping_cost': shippingCost,
    'quality_claim': qualityClaim,
    'note': note,
    'is_issued': isIssued,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'delivery_order': deliveryOrder?.toJson(),
  };
}

class DeliveryOrder {
  final String? id;
  final String? pksId;
  final String? destinationId;
  final String? billingId;
  final String? commodityId;
  final String? siteId;
  final String? doNumber;
  final String? doDate;
  final String? loadPlanDate;
  final int? quantity;
  final int? remainingQty;
  final int? qualityClaim;
  final int? commodityPrice;
  final String? status;
  final int? isTransshipment;
  final String? contractNumber;
  final String? salesContractNumber;
  final String? invoiceType;
  final String? description;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  DeliveryOrder({
    this.id,
    this.pksId,
    this.destinationId,
    this.billingId,
    this.commodityId,
    this.siteId,
    this.doNumber,
    this.doDate,
    this.loadPlanDate,
    this.quantity,
    this.remainingQty,
    this.qualityClaim,
    this.commodityPrice,
    this.status,
    this.isTransshipment,
    this.contractNumber,
    this.salesContractNumber,
    this.invoiceType,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryOrder(
      id: json['id'] as String?,
      pksId: json['pks_id'] as String?,
      destinationId: json['destination_id'] as String?,
      billingId: json['billing_id'] as String?,
      commodityId: json['commodity_id'] as String?,
      siteId: json['site_id'] as String?,
      doNumber: json['do_number'] as String?,
      doDate: json['do_date'] as String?,
      loadPlanDate: json['load_plan_date'] as String?,
      quantity: json['quantity'] as int?,
      remainingQty: json['remaining_qty'] as int?,
      qualityClaim: json['quality_claim'] as int?,
      commodityPrice: json['commodity_price'] as int?,
      status: json['status'] as String?,
      isTransshipment: json['is_transshipment'] as int?,
      contractNumber: json['contract_number'] as String?,
      salesContractNumber: json['sales_contract_number'] as String?,
      invoiceType: json['invoice_type'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as int?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      deletedBy: json['deleted_by'] as String?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'pks_id': pksId,
    'destination_id': destinationId,
    'billing_id': billingId,
    'commodity_id': commodityId,
    'site_id': siteId,
    'do_number': doNumber,
    'do_date': doDate,
    'load_plan_date': loadPlanDate,
    'quantity': quantity,
    'remaining_qty': remainingQty,
    'quality_claim': qualityClaim,
    'commodity_price': commodityPrice,
    'status': status,
    'is_transshipment': isTransshipment,
    'contract_number': contractNumber,
    'sales_contract_number': salesContractNumber,
    'invoice_type': invoiceType,
    'description': description,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
