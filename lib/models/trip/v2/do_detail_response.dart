import '../list_new_do_response.dart';
import '../show_do_response.dart'
    show TripAllowance, WalletTransaction, FileData;

class DoDetailResponse {
  final String status;
  final DoDetailResponseData data;

  DoDetailResponse({
    required this.status,
    required this.data,
  });

  factory DoDetailResponse.fromJson(Map<String, dynamic> json) {
    return DoDetailResponse(
      status: json['status'],
      data: DoDetailResponseData.fromJson(json['data']),
    );
  }
}

class DoDetailResponseData {
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

  final Status? status;
  final String? latestStatusLog;

  final String? spbNumber;
  final int? shippingCost;
  final dynamic qualityClaim;

  final String? note;

  final int? isIssued;
  final int? isActive;

  final DeliveryOrder? deliveryOrder;
  final Driver? driver;
  final Vehicle? vehicle;
  final LinkedDetail? linkedDetail;

  final TripAllowance? tripAllowance;
  final WalletTransaction? walletTransaction;

  final List<FileData>? files;

  DoDetailResponseData({
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
    this.deliveryOrder,
    this.driver,
    this.vehicle,
    this.linkedDetail,
    this.tripAllowance,
    this.walletTransaction,
    this.files,
  });

  factory DoDetailResponseData.fromJson(Map<String, dynamic> json) {
    return DoDetailResponseData(
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

      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      latestStatusLog: json['latest_status_log'],

      spbNumber: json['spb_number'],
      shippingCost: json['shipping_cost'],
      qualityClaim: json['quality_claim'],

      note: json['note'],

      isIssued: json['is_issued'],
      isActive: json['is_active'],

      deliveryOrder: json['delivery_order'] != null
          ? DeliveryOrder.fromJson(json['delivery_order'])
          : null,

      driver:
      json['driver'] != null ? Driver.fromJson(json['driver']) : null,

      vehicle:
      json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,

      linkedDetail: json['linked_detail'] != null
          ? LinkedDetail.fromJson(json['linked_detail'])
          : null,

      tripAllowance: json['trip_allowance'] != null
          ? TripAllowance.fromJson(json['trip_allowance'])
          : null,

      walletTransaction: json['wallet_transaction'] != null
          ? WalletTransaction.fromJson(json['wallet_transaction'])
          : null,

      files: json['files'] != null
          ? (json['files'] as List)
          .map((e) => FileData.fromJson(e))
          .toList()
          : null,
    );
  }
}


class Status {
  final String? id;
  final String? fieldName;
  final String? fieldValue;
  final String? name;
  final String? code;
  final int? sort;
  final String? description;
  final String? color;

  Status({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      fieldName: json['field_name'],
      fieldValue: json['field_value'],
      name: json['name'],
      code: json['code'],
      sort: json['sort'],
      description: json['description'],
      color: json['color'],
    );
  }
}


class DeliveryOrder {
  final String? id;
  final String? pksId;
  final String? destinationId;
  final String? billingId;
  final String? commodityId;

  final String? doNumber;
  final String? doDate;

  final int? quantity;
  final int? remainingQty;
  final int? commodityPrice;

  final String? status;
  final String? contractNumber;

  final double? progressPercentage;

  final Pks? pks;
  final Destination? destination;
  final Billing? billing;
  final Commodity? commodity;

  DeliveryOrder({
    this.id,
    this.pksId,
    this.destinationId,
    this.billingId,
    this.commodityId,
    this.doNumber,
    this.doDate,
    this.quantity,
    this.remainingQty,
    this.commodityPrice,
    this.status,
    this.contractNumber,
    this.progressPercentage,
    this.pks,
    this.destination,
    this.billing,
    this.commodity,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    return DeliveryOrder(
      id: json['id'],
      pksId: json['pks_id'],
      destinationId: json['destination_id'],
      billingId: json['billing_id'],
      commodityId: json['commodity_id'],

      doNumber: json['do_number'],
      doDate: json['do_date'],

      quantity: json['quantity'],
      remainingQty: json['remaining_qty'],
      commodityPrice: json['commodity_price'],

      status: json['status'],
      contractNumber: json['contract_number'],

      progressPercentage: json['progress_percentage'] != null
          ? double.tryParse(json['progress_percentage'].toString())
          : null,

      pks: json['pks'] != null ? Pks.fromJson(json['pks']) : null,
      destination: json['destination'] != null
          ? Destination.fromJson(json['destination'])
          : null,
      billing:
      json['billing'] != null ? Billing.fromJson(json['billing']) : null,
      commodity: json['commodity'] != null
          ? Commodity.fromJson(json['commodity'])
          : null,
    );
  }
}


class Pks {
  final String? id;
  final String? siteId;
  final String? code;
  final String? name;
  final String? address;
  final String? description;

  Pks({
    this.id,
    this.siteId,
    this.code,
    this.name,
    this.address,
    this.description,
  });

  factory Pks.fromJson(Map<String, dynamic> json) {
    return Pks(
      id: json['id'],
      siteId: json['site_id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
    );
  }
}

class Destination {
  final String? id;
  final String? siteId;
  final String? code;
  final String? name;
  final String? address;
  final String? description;

  Destination({
    this.id,
    this.siteId,
    this.code,
    this.name,
    this.address,
    this.description,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      siteId: json['site_id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
    );
  }
}


class Billing {
  final String? id;
  final String? siteId;
  final String? code;
  final String? name;

  final String? npwp;
  final String? billingName;
  final String? address;
  final String? npwpAddress;
  final String? billingAddress;

  final int? isPph;
  final String? description;

  Billing({
    this.id,
    this.siteId,
    this.code,
    this.name,
    this.npwp,
    this.billingName,
    this.address,
    this.npwpAddress,
    this.billingAddress,
    this.isPph,
    this.description,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      id: json['id'],
      siteId: json['site_id'],
      code: json['code'],
      name: json['name'],
      npwp: json['npwp'],
      billingName: json['billing_name'],
      address: json['address'],
      npwpAddress: json['npwp_address'],
      billingAddress: json['billing_address'],
      isPph: json['is_pph'],
      description: json['description'],
    );
  }
}


class Commodity {
  final String? id;
  final String? code;
  final String? name;
  final String? description;

  Commodity({
    this.id,
    this.code,
    this.name,
    this.description,
  });

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
    );
  }
}

