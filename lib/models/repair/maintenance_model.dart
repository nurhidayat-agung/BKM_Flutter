class MaintenanceListData {
  String? id;
  String? siteId;
  String? requestedBy;
  String? vehicleId;
  String? mechanicId;
  String? maintenanceTypeId;
  int? isInternal;
  String? externalWorkshopName;
  String? requestNumber;
  int? queueNumber;
  String? queueMonth;
  PriorityModel? priority;
  StatusModel? status;
  String? requestAt;
  int? currentKm;
  String? description;
  String? approvedBy;
  String? approvedAt;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  RequestedModel? requested;
  MechanicModel? mechanic;
  VehicleModel? vehicle;
  MaintenanceTypeModel? maintenanceType;
  List<Damage?>? damages;
  List<dynamic>? logs;

  MaintenanceListData({
    this.id,
    this.siteId,
    this.requestedBy,
    this.vehicleId,
    this.mechanicId,
    this.maintenanceTypeId,
    this.isInternal,
    this.externalWorkshopName,
    this.requestNumber,
    this.queueNumber,
    this.queueMonth,
    this.priority,
    this.status,
    this.requestAt,
    this.currentKm,
    this.description,
    this.approvedBy,
    this.approvedAt,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.requested,
    this.mechanic,
    this.vehicle,
    this.maintenanceType,
    this.damages,
    this.logs,
  });

  factory MaintenanceListData.fromJson(Map<String, dynamic> json) {
    return MaintenanceListData(
      id: json['id'],
      siteId: json['site_id'],
      requestedBy: json['requested_by'],
      vehicleId: json['vehicle_id'],
      mechanicId: json['mechanic_id'],
      maintenanceTypeId: json['maintenance_type_id'],
      isInternal: json['is_internal'],
      externalWorkshopName: json['external_workshop_name'],
      requestNumber: json['request_number'],
      queueNumber: json['queue_number'],
      queueMonth: json['queue_month'],
      priority: json['priority'] != null
          ? PriorityModel.fromJson(json['priority'])
          : null,
      status: json['status'] != null
          ? StatusModel.fromJson(json['status'])
          : null,
      requestAt: json['request_at'],
      currentKm: json['current_km'],
      description: json['description'],
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      requested: json['requested'] != null
          ? RequestedModel.fromJson(json['requested'])
          : null,
      mechanic: json['mechanic'] != null
          ? MechanicModel.fromJson(json['mechanic'])
          : null,
      vehicle: json['vehicle'] != null
          ? VehicleModel.fromJson(json['vehicle'])
          : null,
      maintenanceType: json['maintenance_type'] != null
          ? MaintenanceTypeModel.fromJson(json['maintenance_type'])
          : null,
      damages: json['damages'] != null
          ? (json['damages'] as List)
          .map((e) => Damage.fromJson(e))
          .toList()
          : [],
      logs: json['logs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'site_id': siteId,
      'requested_by': requestedBy,
      'vehicle_id': vehicleId,
      'mechanic_id': mechanicId,
      'maintenance_type_id': maintenanceTypeId,
      'is_internal': isInternal,
      'external_workshop_name': externalWorkshopName,
      'request_number': requestNumber,
      'queue_number': queueNumber,
      'queue_month': queueMonth,
      'priority': priority?.toJson(),
      'status': status?.toJson(),
      'request_at': requestAt,
      'current_km': currentKm,
      'description': description,
      'approved_by': approvedBy,
      'approved_at': approvedAt,
      'is_active': isActive,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'requested': requested?.toJson(),
      'mechanic': mechanic?.toJson(),
      'vehicle': vehicle?.toJson(),
      'maintenance_type': maintenanceType?.toJson(),
      'damages': damages,
      'logs': logs,
    };
  }
}

class PriorityModel {
  String? id;
  String? fieldName;
  String? fieldValue;
  String? name;
  String? code;
  int? sort;
  String? description;
  String? color;
  String? colorHex;
  int? isActive;

  PriorityModel({
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

  factory PriorityModel.fromJson(Map<String, dynamic> json) {
    return PriorityModel(
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

  Map<String, dynamic> toJson() => {
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

class StatusModel extends PriorityModel {
  StatusModel({
    super.id,
    super.fieldName,
    super.fieldValue,
    super.name,
    super.code,
    super.sort,
    super.description,
    super.color,
    super.colorHex,
    super.isActive,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
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
}

class RequestedModel {
  String? id;
  String? siteId;
  String? name;
  String? code;
  String? phoneNumber;
  String? address;
  int? isActive;

  RequestedModel({
    this.id,
    this.siteId,
    this.name,
    this.code,
    this.phoneNumber,
    this.address,
    this.isActive,
  });

  factory RequestedModel.fromJson(Map<String, dynamic> json) {
    return RequestedModel(
      id: json['id'],
      siteId: json['site_id'],
      name: json['name'],
      code: json['code'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_id': siteId,
    'name': name,
    'code': code,
    'phone_number': phoneNumber,
    'address': address,
    'is_active': isActive,
  };
}

class VehicleModel {
  String? id;
  String? policeNumber;
  String? chassisNumber;
  int? productionYear;
  int? capacity;
  int? isActive;

  VehicleModel({
    this.id,
    this.policeNumber,
    this.chassisNumber,
    this.productionYear,
    this.capacity,
    this.isActive,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      policeNumber: json['police_number'],
      chassisNumber: json['chassis_number'],
      productionYear: json['production_year'],
      capacity: json['capacity'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'police_number': policeNumber,
    'chassis_number': chassisNumber,
    'production_year': productionYear,
    'capacity': capacity,
    'is_active': isActive,
  };
}

class MaintenanceTypeModel {
  String? id;
  String? fieldName;
  String? fieldValue;
  String? name;
  String? code;
  int? sort;
  int? isActive;

  MaintenanceTypeModel({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.isActive,
  });

  factory MaintenanceTypeModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceTypeModel(
      id: json['id'],
      fieldName: json['field_name'],
      fieldValue: json['field_value'],
      name: json['name'],
      code: json['code'],
      sort: json['sort'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'field_name': fieldName,
    'field_value': fieldValue,
    'name': name,
    'code': code,
    'sort': sort,
    'is_active': isActive,
  };
}

class MechanicModel {
  String? id;
  String? siteId;
  String? userId;
  String? name;
  String? code;
  String? phoneNumber;
  String? status;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  MechanicModel({
    this.id,
    this.siteId,
    this.userId,
    this.name,
    this.code,
    this.phoneNumber,
    this.status,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory MechanicModel.fromJson(Map<String, dynamic> json) {
    return MechanicModel(
      id: json['id'],
      siteId: json['site_id'],
      userId: json['user_id'],
      name: json['name'],
      code: json['code'],
      phoneNumber: json['phone_number'],
      status: json['status'],
      description: json['description'],
      isActive: json['is_active'],
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
      'code': code,
      'phone_number': phoneNumber,
      'status': status,
      'description': description,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class DamageType {
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

  DamageType({
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

  factory DamageType.fromJson(Map<String, dynamic> json) {
    return DamageType(
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

class Damage {
  final String? id;
  final String? maintenanceRequestId;
  final DamageType? damageType;
  final String? severity;
  final String? description;
  final int? isActive;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Damage({
    this.id,
    this.maintenanceRequestId,
    this.damageType,
    this.severity,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Damage.fromJson(Map<String, dynamic> json) {
    return Damage(
      id: json['id'],
      maintenanceRequestId: json['maintenance_request_id'],
      damageType: json['damage_type'] != null
          ? DamageType.fromJson(json['damage_type'])
          : null,
      severity: json['severity'],
      description: json['description'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'maintenance_request_id': maintenanceRequestId,
      'damage_type': damageType?.toJson(),
      'severity': severity,
      'description': description,
      'is_active': isActive,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}



