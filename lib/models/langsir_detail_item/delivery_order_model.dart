import 'package:newbkmmobile/core/R/json_safe.dart';
import 'package:newbkmmobile/models/langsir_detail/pks_dest_com_billing.dart';

class DeliveryOrderModel {
  final String? id;
  final String? doNumber;
  final String? doDate;
  final int? quantity;
  final int? remainingQty;
  final double? progressPercentage;

  final PksModel? pks;
  final DestinationModel? destination;
  final CommodityModel? commodity;
  final BillingModel? billing;

  DeliveryOrderModel({
    this.id,
    this.doNumber,
    this.doDate,
    this.quantity,
    this.remainingQty,
    this.progressPercentage,
    this.pks,
    this.destination,
    this.commodity,
    this.billing,
  });

  factory DeliveryOrderModel.fromJson(Map<String, dynamic> json) {
    return DeliveryOrderModel(
      id: safeString(json['id']),
      doNumber: safeString(json['do_number']),
      doDate: safeString(json['do_date']),
      quantity: safeInt(json['quantity']),
      remainingQty: safeInt(json['remaining_qty']),
      progressPercentage: safeDouble(json['progress_percentage']),
      pks: safeParse(json['pks'], (e) => PksModel.fromJson(e)),
      destination:
      safeParse(json['destination'], (e) => DestinationModel.fromJson(e)),
      commodity:
      safeParse(json['commodity'], (e) => CommodityModel.fromJson(e)),
      billing: safeParse(json['billing'], (e) => BillingModel.fromJson(e)),
    );
  }
}
