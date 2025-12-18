import 'package:newbkmmobile/models/langsir/local_hauling_commodity.dart';
import 'package:newbkmmobile/models/langsir/local_hauling_destination.dart';
import 'package:newbkmmobile/models/langsir/local_hauling_pks.dart';
import 'package:newbkmmobile/models/langsir/local_hauling_status.dart';

class LocalHaulingData {
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

  final LocalHaulingStatus? status;

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

  final double? progressPercentage;

  final LocalHaulingPks? pks;
  final LocalHaulingDestination? destination;
  final LocalHaulingCommodity? commodity;

  LocalHaulingData({
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
  });

  factory LocalHaulingData.fromJson(Map<String, dynamic> json) {
    return LocalHaulingData(
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

      status: json['status'] != null
          ? LocalHaulingStatus.fromJson(json['status'])
          : null,

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

      progressPercentage:
      (json['progress_percentage'] as num?)?.toDouble(),

      pks: json['pks'] != null
          ? LocalHaulingPks.fromJson(json['pks'])
          : null,

      destination: json['destination'] != null
          ? LocalHaulingDestination.fromJson(json['destination'])
          : null,

      commodity: json['commodity'] != null
          ? LocalHaulingCommodity.fromJson(json['commodity'])
          : null,
    );
  }
}
