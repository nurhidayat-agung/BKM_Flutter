class DeliveryOrderHistory {
  String? id;
  String? pksId;
  String? destinationId;
  String? billingId;
  String? commodityId;
  String? siteId;

  String? doNumber;
  String? doDate;
  String? loadPlanDate;

  num? quantity;
  num? remainingQty;
  num? qualityClaim;
  num? commodityPrice;
  String? status;

  int? isTransshipment;

  String? contractNumber;
  String? salesContractNumber;
  String? invoiceType;
  String? description;

  int? isActive;

  String? createdBy;
  String? updatedBy;
  String? deletedBy;

  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  double? progressPercentage;

  PksDestinationHistory? pks;
  PksDestinationHistory? destination;
  CommodityDataHistory? commodity;
  BillingHistory? billing;

  DeliveryOrderHistory({
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
    this.progressPercentage,
    this.pks,
    this.destination,
    this.commodity,
    this.billing,
  });

  factory DeliveryOrderHistory.fromJson(Map<String, dynamic> json) {
    return DeliveryOrderHistory(
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

      progressPercentage: json['progress_percentage']?.toDouble(),

      pks: json['pks'] != null ? PksDestinationHistory.fromJson(json['pks']) : null,
      destination: json['destination'] != null ? PksDestinationHistory.fromJson(json['destination']) : null,
      commodity: json['commodity'] != null ? CommodityDataHistory.fromJson(json['commodity']) : null,
      billing: json['billing'] != null ? BillingHistory.fromJson(json['billing']) : null,
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
      'progress_percentage': progressPercentage,
      'pks': pks?.toJson(),
      'destination': destination?.toJson(),
      'commodity': commodity?.toJson(),
      'billing': billing?.toJson(),
    };
  }
}

class PksDestinationHistory {
  String? id;
  String? siteId;
  String? code;
  String? name;
  String? address;
  String? description;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  PksDestinationHistory({
    this.id,
    this.siteId,
    this.code,
    this.name,
    this.address,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PksDestinationHistory.fromJson(Map<String, dynamic> json) {
    return PksDestinationHistory(
      id: json['id'],
      siteId: json['site_id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
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
      'code': code,
      'name': name,
      'address': address,
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

class BillingHistory {
  String? id;
  String? siteId;
  String? code;
  String? name;
  String? npwp;
  String? billingName;
  String? address;
  String? npwpAddress;
  String? billingAddress;
  int? isPph;
  String? description;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BillingHistory({
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
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BillingHistory.fromJson(Map<String, dynamic> json) {
    return BillingHistory(
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
      'code': code,
      'name': name,
      'npwp': npwp,
      'billing_name': billingName,
      'address': address,
      'npwp_address': npwpAddress,
      'billing_address': billingAddress,
      'is_pph': isPph,
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

class CommodityDataHistory {
  String? id;
  String? code;
  String? name;
  String? description;
  int? isActive;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CommodityDataHistory({
    this.id,
    this.code,
    this.name,
    this.description,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CommodityDataHistory.fromJson(Map<String, dynamic> json) {
    return CommodityDataHistory(
      id: json['id'],
      code: json['code'],
      name: json['name'],
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
      'code': code,
      'name': name,
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



