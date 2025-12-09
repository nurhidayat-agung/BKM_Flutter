import 'dart:convert';

import 'package:newbkmmobile/models/trip_history/v2/delivery_order_history.dart';

class ShowDoResponse {
  final String? status;
  final ShowDoData? data;

  ShowDoResponse({
    this.status,
    this.data,
  });

  factory ShowDoResponse.fromJson(Map<String, dynamic> json) {
    return ShowDoResponse(
      status: json['status'] as String?,
      data: json['data'] != null
          ? ShowDoData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.toJson(),
  };
}

//Tambahan Model PKS
class Pks {
  final String? id;
  final String? name;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  Pks({
    this.id,
    this.name,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory Pks.fromJson(Map<String, dynamic> json) => Pks(
    id: json['id'] as String?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}//PKS

//Tambahan Model Destination
class Destination {
  final String? id;
  final String? name;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  Destination({
    this.id,
    this.name,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    id: json['id'] as String?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}//Destination

//Tambahan Model Commodity
class Commodity {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  Commodity({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Commodity.fromJson(Map<String, dynamic> json) => Commodity(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
} //Comodity

//Tambahan Model DeliveryOrder
class DeliveryOrder {
  final String? id;
  final String? pksId;
  final String? destinationId;
  final String? billingId;
  final String? commodity;
  final String? siteId;
  final String? doNumber;
  final String? doDate;
  final int? prevDoNumber;
  final String? loadPlanDate;
  final int? quantity;
  final int? remainingQty;
  final int? qualityClaim;
  final dynamic commodityPrice;
  final String? status;
  final int? isTransshipment;
  final String? contractNumber;
  final String? salesContractNumber;
  final dynamic invoiceType;
  final String? description;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final PksDestinationHistory? pks;
  final PksDestinationHistory? destination;


  DeliveryOrder({
    this.id,
    this.pksId,
    this.destinationId,
    this.billingId,
    this.commodity,
    this.siteId,
    this.doNumber,
    this.doDate,
    this.prevDoNumber,
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
    this.pks,
    this.destination
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DeliveryOrder();

    return DeliveryOrder(
      id: json['id'] as String?,
      pksId: json['pks_id'] as String?,
      destinationId: json['destination_id'] as String?,
      billingId: json['billing_id'] as String?,
      commodity: json['commodity_id'] as String?,
      siteId: json['site_id'] as String?,
      doNumber: json['do_number'] as String?,
      doDate: json['do_date'] as String?,
      loadPlanDate: json['load_plan_date'] as String?,
      quantity: json['quantity'] as int?,
      remainingQty: json['remaining_qty'] as int?,
      qualityClaim: json['quality_claim'] as int?,
      commodityPrice: json['commodity_price'],
      status: json['status'] as String?,
      isTransshipment: json['is_transshipment'] as int?,
      contractNumber: json['contract_number'] as String?,
      salesContractNumber: json['sales_contract_number'] as String?,
      invoiceType: json['invoice_type'],
      description: json['description'] as String?,
      isActive: json['is_active'] as int?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      deletedBy: json['deleted_by'] as String?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pks: json['pks'] != null ? PksDestinationHistory.fromJson(json['pks']) : null,
      destination: json['destination'] != null ? PksDestinationHistory.fromJson(json['destination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pks_id': pksId,
      'destination_id': destinationId,
      'billing_id': billingId,
      'commodity_id': commodity,
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
    }..removeWhere((key, value) => value == null); // optional: hapus field null
  }
}

class ShowDoData {
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
  final Driver? driver;
  final Vehicle? vehicle;
  final LinkedDetail? linkedDetail;
  final TripAllowance? tripAllowance;
  final WalletTransaction? walletTransaction;
  final List<FileData>? files;
  final List<dynamic>? appLogs;
  //Tambahan baru
  final DeliveryOrder? deliveryOrder;
  final String? driverName;
  final String? vehiclePlate;
  final Pks? pks;
  final Destination? destination;
  final Commodity? commodity;


  ShowDoData({
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
    this.files,
    this.appLogs,
    //Tambahan baru
    this.deliveryOrder,
    this.driverName,
    this.vehiclePlate,
    this.pks,
    this.destination,
    this.commodity,
  });

  factory ShowDoData.fromJson(Map<String, dynamic> json) => ShowDoData(
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
    status: json['status'] != null ? Status.fromJson(json['status']) : null,
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
    driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
    vehicle: json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
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
        ? (json['files'] as List).map((e) => FileData.fromJson(e)).toList()
        : null,
    appLogs: json['app_logs'] as List<dynamic>?,
    //Tambahan baru
    deliveryOrder: json['delivery_order'] != null
        ? DeliveryOrder.fromJson(json['delivery_order'])
        : null,
    driverName: json['driver_name']?.toString(),
    vehiclePlate: json['vehicle_plate']?.toString(),
    pks: json['pks'] != null ? Pks.fromJson(json['pks']) : null,
    destination: json['destination'] != null ? Destination.fromJson(json['destination']) : null,
    commodity: json['commodity'] != null ? Commodity.fromJson(json['commodity']) : null,
  );

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
    'status': status?.toJson(),
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
    'driver': driver?.toJson(),
    'vehicle': vehicle?.toJson(),
    'linked_detail': linkedDetail?.toJson(),
    'trip_allowance': tripAllowance?.toJson(),
    'wallet_transaction': walletTransaction?.toJson(),
    'files': files?.map((e) => e.toJson()).toList(),
    'app_logs': appLogs,
    //Tambahan baru
    'pks': pks?.toJson(),
    'destination': destination?.toJson(),
    'commodity': commodity?.toJson(),
  };
}

// ================= Nested Classes =================
class Status {
  final String? id;
  final String? fieldName;
  final String? fieldValue;
  final String? name;
  final String? code;
  final int? sort;
  final String? description;
  final String? color;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  Status({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json['id'] as String?,
    fieldName: json['field_name'] as String?,
    fieldValue: json['field_value'] as String?,
    name: json['name'] as String?,
    code: json['code'] as String?,
    sort: json['sort'] as int?,
    description: json['description'] as String?,
    color: json['color'] as String?,
    isActive: json['is_active'] as int?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    deletedBy: json['deleted_by'] as String?,
    deletedAt: json['deleted_at'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'field_name': fieldName,
    'field_value': fieldValue,
    'name': name,
    'code': code,
    'sort': sort,
    'description': description,
    'color': color,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Driver {
  final String? id;
  final String? siteId;
  final String? userId;
  final String? name;
  final String? alias;
  final String? code;
  final String? status;
  final String? ein;
  final String? dateOfBirth;
  final String? placeOfBirth;
  final String? lastEducation;
  final String? gender;
  final String? nik;
  final String? simNumber;
  final String? simType;
  final String? bpjsNumber;
  final String? kkNumber;
  final String? rekeningNumber;
  final String? phoneNumber;
  final int? isBackupDriver;
  final String? activeWorkingDate;
  final String? address;
  final String? bloodType;
  final String? statusDesc;
  final String? description;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  Driver({
    this.id,
    this.siteId,
    this.userId,
    this.name,
    this.alias,
    this.code,
    this.status,
    this.ein,
    this.dateOfBirth,
    this.placeOfBirth,
    this.lastEducation,
    this.gender,
    this.nik,
    this.simNumber,
    this.simType,
    this.bpjsNumber,
    this.kkNumber,
    this.rekeningNumber,
    this.phoneNumber,
    this.isBackupDriver,
    this.activeWorkingDate,
    this.address,
    this.bloodType,
    this.statusDesc,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json['id'] as String?,
    siteId: json['site_id'] as String?,
    userId: json['user_id'] as String?,
    name: json['name'] as String?,
    alias: json['alias'] as String?,
    code: json['code'] as String?,
    status: json['status'] as String?,
    ein: json['ein'] as String?,
    dateOfBirth: json['date_of_birth'] as String?,
    placeOfBirth: json['place_of_birth'] as String?,
    lastEducation: json['last_education'] as String?,
    gender: json['gender'] as String?,
    nik: json['nik'] as String?,
    simNumber: json['sim_number'] as String?,
    simType: json['sim_type'] as String?,
    bpjsNumber: json['bpjs_number'] as String?,
    kkNumber: json['kk_number'] as String?,
    rekeningNumber: json['rekening_number'] as String?,
    phoneNumber: json['phone_number'] as String?,
    isBackupDriver: json['is_backup_driver'] as int?,
    activeWorkingDate: json['active_working_date'] as String?,
    address: json['address'] as String?,
    bloodType: json['blood_type'] as String?,
    statusDesc: json['status_desc'] as String?,
    description: json['description'] as String?,
    isActive: json['is_active'] as int?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    deletedBy: json['deleted_by'] as String?,
    deletedAt: json['deleted_at'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_id': siteId,
    'user_id': userId,
    'name': name,
    'alias': alias,
    'code': code,
    'status': status,
    'ein': ein,
    'date_of_birth': dateOfBirth,
    'place_of_birth': placeOfBirth,
    'last_education': lastEducation,
    'gender': gender,
    'nik': nik,
    'sim_number': simNumber,
    'sim_type': simType,
    'bpjs_number': bpjsNumber,
    'kk_number': kkNumber,
    'rekening_number': rekeningNumber,
    'phone_number': phoneNumber,
    'is_backup_driver': isBackupDriver,
    'active_working_date': activeWorkingDate,
    'address': address,
    'blood_type': bloodType,
    'status_desc': statusDesc,
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

class Vehicle {
  final String? id;
  final String? siteId;
  final String? typeVehicleId;
  final String? fuelTypeId;
  final String? pic;
  final String? status;
  final String? policeNumber;
  final String? stnkNumber;
  final String? stnkExpiration;
  final String? taxExpiration;
  final String? kirExpiration;
  final String? chassisNumber;
  final String? machineNumber;
  final int? capacity;
  final int? estimatedLoad;
  final int? productionYear;
  final String? terminal;
  final String? description;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  Vehicle({
    this.id,
    this.siteId,
    this.typeVehicleId,
    this.fuelTypeId,
    this.pic,
    this.status,
    this.policeNumber,
    this.stnkNumber,
    this.stnkExpiration,
    this.taxExpiration,
    this.kirExpiration,
    this.chassisNumber,
    this.machineNumber,
    this.capacity,
    this.estimatedLoad,
    this.productionYear,
    this.terminal,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json['id'] as String?,
    siteId: json['site_id'] as String?,
    typeVehicleId: json['type_vehicle_id'] as String?,
    fuelTypeId: json['fuel_type_id'] as String?,
    pic: json['pic'] as String?,
    status: json['status'] as String?,
    policeNumber: json['police_number'] as String?,
    stnkNumber: json['stnk_number'] as String?,
    stnkExpiration: json['stnk_expiration'] as String?,
    taxExpiration: json['tax_expiration'] as String?,
    kirExpiration: json['kir_expiration'] as String?,
    chassisNumber: json['chassis_number'] as String?,
    machineNumber: json['machine_number'] as String?,
    capacity: json['capacity'] as int?,
    estimatedLoad: json['estimated_load'] as int?,
    productionYear: json['production_year'] as int?,
    terminal: json['terminal'] as String?,
    description: json['description'] as String?,
    isActive: json['is_active'] as int?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    deletedBy: json['deleted_by'] as String?,
    deletedAt: json['deleted_at'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_id': siteId,
    'type_vehicle_id': typeVehicleId,
    'fuel_type_id': fuelTypeId,
    'pic': pic,
    'status': status,
    'police_number': policeNumber,
    'stnk_number': stnkNumber,
    'stnk_expiration': stnkExpiration,
    'tax_expiration': taxExpiration,
    'kir_expiration': kirExpiration,
    'chassis_number': chassisNumber,
    'machine_number': machineNumber,
    'capacity': capacity,
    'estimated_load': estimatedLoad,
    'production_year': productionYear,
    'terminal': terminal,
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



class LinkedDetail {
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
  final dynamic latestStatusLog;
  final String? spbNumber;
  final int? shippingCost;
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
  final DeliveryOrder? deliveryOrder;

  LinkedDetail({
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

  factory LinkedDetail.fromJson(Map<String, dynamic>? json) {
    if (json == null) return LinkedDetail();

    return LinkedDetail(
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
      latestStatusLog: json['latest_status_log'],
      spbNumber: json['spb_number'] as String?,
      shippingCost: json['shipping_cost'] as int?,
      qualityClaim: json['quality_claim'],
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
          ? DeliveryOrder.fromJson(json['delivery_order'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    }..removeWhere((key, value) => value == null); // optional: bersihkan null
  }
}


class TripAllowance {
  final String? id;
  final String? siteId;
  final String? doDetailId;
  final String? originalAmount;
  final String? amount;
  final String? saving;
  final String? transferredAmount;
  final String? status;
  final String? transferAt;
  final String? notes;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  TripAllowance({
    this.id,
    this.siteId,
    this.doDetailId,
    this.originalAmount,
    this.amount,
    this.saving,
    this.transferredAmount,
    this.status,
    this.transferAt,
    this.notes,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory TripAllowance.fromJson(Map<String, dynamic> json) => TripAllowance(
    id: json['id'] as String?,
    siteId: json['site_id'] as String?,
    doDetailId: json['do_detail_id'] as String?,
    originalAmount: json['original_amount'] as String?,
    amount: json['amount'] as String?,
    saving: json['saving'] as String?,
    transferredAmount: json['transferred_amount'] as String?,
    status: json['status'] as String?,
    transferAt: json['transfer_at'] as String?,
    notes: json['notes'] as String?,
    isActive: json['is_active'] as int?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    deletedBy: json['deleted_by'] as String?,
    deletedAt: json['deleted_at'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_id': siteId,
    'do_detail_id': doDetailId,
    'original_amount': originalAmount,
    'amount': amount,
    'saving': saving,
    'transferred_amount': transferredAmount,
    'status': status,
    'transfer_at': transferAt,
    'notes': notes,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}


class WalletTransaction {
  final String? id;
  final String? walletId;
  final String? doDetailId;
  final String? type;
  final String? amount;
  final String? direction;
  final String? data;
  final String? description;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  WalletTransaction({
    this.id,
    this.walletId,
    this.doDetailId,
    this.type,
    this.amount,
    this.direction,
    this.data,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
    id: json['id'] as String?,
    walletId: json['wallet_id'] as String?,
    doDetailId: json['do_detail_id'] as String?,
    type: json['type'] as String?,
    amount: json['amount'] as String?,
    direction: json['direction'] as String?,
    data: json['data'] as String?,
    description: json['description'] as String?,
    isActive: json['is_active'] as int?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    deletedBy: json['deleted_by'] as String?,
    deletedAt: json['deleted_at'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'wallet_id': walletId,
    'do_detail_id': doDetailId,
    'type': type,
    'amount': amount,
    'direction': direction,
    'data': data,
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


class FileData {
  final String? id;
  final String? sourceId;
  final String? code;
  final String? originalName;
  final String? fileName;
  final String? mimeType;
  final int? size;
  final String? disk;
  final String? path;
  final String? url;
  final String? categoryId;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  FileData({
    this.id,
    this.sourceId,
    this.code,
    this.originalName,
    this.fileName,
    this.mimeType,
    this.size,
    this.disk,
    this.path,
    this.url,
    this.categoryId,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory FileData.fromJson(Map<String, dynamic> json) => FileData(
    id: json['id'] as String?,
    sourceId: json['source_id'] as String?,
    code: json['code'] as String?,
    originalName: json['original_name'] as String?,
    fileName: json['file_name'] as String?,
    mimeType: json['mime_type'] as String?,
    size: json['size'] as int?,
    disk: json['disk'] as String?,
    path: json['path'] as String?,
    url: json['url'] as String?,
    categoryId: json['category_id'] as String?,
    isActive: json['is_active'] as int?,
    createdBy: json['created_by'] as String?,
    updatedBy: json['updated_by'] as String?,
    deletedBy: json['deleted_by'] as String?,
    deletedAt: json['deleted_at'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'source_id': sourceId,
    'code': code,
    'original_name': originalName,
    'file_name': fileName,
    'mime_type': mimeType,
    'size': size,
    'disk': disk,
    'path': path,
    'url': url,
    'category_id': categoryId,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}



// ================= Vehicle, LinkedDetail, TripAllowance, WalletTransaction, FileData =================
// Struktur sama seperti Driver/Status, hanya berbeda field.
// Untuk hemat tempat, bisa dibuat mirip seperti Driver dengan nullable semua.
// Jika mau, aku bisa buatkan full class untuk semua nested objects lengkap.

