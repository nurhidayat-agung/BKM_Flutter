import 'dart:convert';

class ListNewDoResponse {
  final String? status;
  final List<ListNewDoData>? data;

  ListNewDoResponse({
    this.status,
    this.data,
  });

  factory ListNewDoResponse.fromJson(Map<String, dynamic> json) {
    return ListNewDoResponse(
      status: json['status'],
      data: json['data'] != null
          ? List<ListNewDoData>.from(
          (json['data'] as List).map((x) => ListNewDoData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}




class ListNewDoData {
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
  final DoStatus? status;
  final String? latestStatusLog;
  final String? spbNumber;
  final int? shippingCost;
  final int? qualityClaim;
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
  final Driver? driver;
  final Vehicle? vehicle;
  final LinkedDetail? linkedDetail;
  final List<AppLog>? appLogs;
  final NextStep? nextStep;

  ListNewDoData({
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
    this.driver,
    this.vehicle,
    this.linkedDetail,
    this.appLogs = const [],
    this.nextStep
  });

  factory ListNewDoData.fromJson(Map<String, dynamic> json) {
    return ListNewDoData(
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
      status: json['status'] != null
          ? DoStatus.fromJson(json['status'])
          : null,
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
      deliveryOrder: json['delivery_order'] != null
          ? DeliveryOrder.fromJson(json['delivery_order'])
          : null,
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      nextStep: json['next_step'] != null ? NextStep.fromJson(json['next_step']) : null,
      vehicle: json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
      linkedDetail: json['linked_detail'] != null
          ? LinkedDetail.fromJson(json['linked_detail'])
          : null,
      appLogs: json['app_logs'] != null
          ? List<AppLog>.from(
          (json['app_logs'] as List)
              .map((x) => AppLog.fromJson(x as Map<String, dynamic>)))
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
      'delivery_order': deliveryOrder?.toJson(),
      'driver': driver?.toJson(),
      'vehicle': vehicle?.toJson(),
      'linked_detail': linkedDetail?.toJson(),
      'app_logs': appLogs?.map((x) => x.toJson()).toList(),
      'next_step' : nextStep?.toJson()
    };
  }
}

class DoStatus {
  final String? id;
  final String? fieldName;
  final String? fieldValue;
  final String? name;
  final String? code;
  final int? sort;
  final String? description;
  final String? color;
  final String? colorHex;
  final int? isActive;

  DoStatus({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.colorHex,
    this.isActive,
  });

  factory DoStatus.fromJson(Map<String, dynamic> json) {
    return DoStatus(
      id: json['id'],
      fieldName: json['field_name'],
      fieldValue: json['field_value'],
      name: json['name'],
      code: json['code'],
      sort: json['sort'],
      description: json['description'],
      color: json['color'],
      colorHex: json['color_hex'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_name': fieldName,
      'field_value': fieldValue,
      'name': name,
      'code': code,
      'sort': sort,
      'description': description,
      'color': color,
      'color_hex': colorHex,
      'is_active': isActive,
    };
  }
}


class NextStep {
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

  NextStep({
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

  factory NextStep.fromJson(Map<String, dynamic> json) {
    return NextStep(
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
  }

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
      id: json['id'],
      pksId: json['pks_id'],
      destinationId: json['destination_id'],
      billingId: json['billing_id'],
      commodityId: json['commodity_id'],
      siteId: json['site_id'],
      doNumber: json['do_number'],
      doDate: json['do_date'],
      loadPlanDate: json['load_plan_date'],
      quantity: json['quantity'],
      remainingQty: json['remaining_qty'],
      qualityClaim: json['quality_claim'],
      commodityPrice: json['commodity_price'],
      status: json['status'],
      isTransshipment: json['is_transshipment'],
      contractNumber: json['contract_number'],
      salesContractNumber: json['sales_contract_number'],
      invoiceType: json['invoice_type'],
      description: json['description'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      siteId: json['site_id'],
      userId: json['user_id'],
      name: json['name'],
      alias: json['alias'],
      code: json['code'],
      status: json['status'],
      ein: json['ein'],
      dateOfBirth: json['date_of_birth'],
      placeOfBirth: json['place_of_birth'],
      lastEducation: json['last_education'],
      gender: json['gender'],
      nik: json['nik'],
      simNumber: json['sim_number'],
      simType: json['sim_type'],
      bpjsNumber: json['bpjs_number'],
      kkNumber: json['kk_number'],
      rekeningNumber: json['rekening_number'],
      phoneNumber: json['phone_number'],
      isBackupDriver: json['is_backup_driver'],
      activeWorkingDate: json['active_working_date'],
      address: json['address'],
      bloodType: json['blood_type'],
      statusDesc: json['status_desc'],
      description: json['description'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      siteId: json['site_id'],
      typeVehicleId: json['type_vehicle_id'],
      fuelTypeId: json['fuel_type_id'],
      pic: json['pic'],
      status: json['status'],
      policeNumber: json['police_number'],
      stnkNumber: json['stnk_number'],
      stnkExpiration: json['stnk_expiration'],
      taxExpiration: json['tax_expiration'],
      kirExpiration: json['kir_expiration'],
      chassisNumber: json['chassis_number'],
      machineNumber: json['machine_number'],
      capacity: json['capacity'],
      estimatedLoad: json['estimated_load'],
      productionYear: json['production_year'],
      terminal: json['terminal'],
      description: json['description'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  final int? loadTare;
  final int? loadBruto;
  final int? unloadTare;
  final int? unloadBruto;
  final String? status;
  final String? latestStatusLog;
  final String? spbNumber;
  final int? shippingCost;
  final int? qualityClaim;
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

  factory LinkedDetail.fromJson(Map<String, dynamic> json) {
    return LinkedDetail(
      id: json['id'],
      doId: json['do_id'],
      vehicleId: json['vehicle_id'],
      driverId: json['driver_id'],
      linkedDetailId: json['linked_detail_id'],
      doNumber: json['do_number'],
      prevDoNumber: json['prev_do_number'],
      loadQuantity: json['load_quantity'],
      unloadQuantity: json['unload_quantity'],
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
      deliveryOrder: json['delivery_order'] != null
          ? DeliveryOrder.fromJson(json['delivery_order'])
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
}

class AppLog {
  final String? id;
  final String? deliveryDetailId;
  final AppLogStatus? status;
  final String? note;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  AppLog({
    this.id,
    this.deliveryDetailId,
    this.status,
    this.note,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AppLog.fromJson(Map<String, dynamic> json) {
    return AppLog(
      id: json['id'] as String?,
      deliveryDetailId: json['delivery_detail_id'] as String?,
      status: json['status'] != null
          ? AppLogStatus.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      note: json['note'] as String?,
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
    'delivery_detail_id': deliveryDetailId,
    'status': status?.toJson(),
    'note': note,
    'is_active': isActive,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class AppLogStatus {
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

  AppLogStatus({
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

  factory AppLogStatus.fromJson(Map<String, dynamic> json) {
    return AppLogStatus(
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
  }

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

