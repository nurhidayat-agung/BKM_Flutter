import 'package:newbkmmobile/models/langsir_detail/do_detail_model.dart';
import 'package:newbkmmobile/models/langsir_detail/pks_dest_com_billing.dart';
import 'package:newbkmmobile/models/langsir_detail/status_model.dart';

class LocalHaulingDetailData {
  final String? id;
  final String? doNumber;
  final String? doDate;
  final int? quantity;
  final int? remainingQty;
  final String? description;
  final double? progressPercentage;

  final StatusModel? status;
  final PksModel? pks;
  final DestinationModel? destination;
  final CommodityModel? commodity;
  final BillingModel? billing;

  final List<DoDetailModel>? doDetails;

  LocalHaulingDetailData({
    this.id,
    this.doNumber,
    this.doDate,
    this.quantity,
    this.remainingQty,
    this.description,
    this.progressPercentage,
    this.status,
    this.pks,
    this.destination,
    this.commodity,
    this.billing,
    this.doDetails,
  });

  factory LocalHaulingDetailData.fromJson(Map<String, dynamic> json) {
    return LocalHaulingDetailData(
      id: json['id'],
      doNumber: json['do_number'],
      doDate: json['do_date'],
      quantity: json['quantity'],
      remainingQty: json['remaining_qty'],
      description: json['description'],
      progressPercentage:
      (json['progress_percentage'] as num?)?.toDouble(),
      status:
      json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      pks: json['pks'] != null ? PksModel.fromJson(json['pks']) : null,
      destination: json['destination'] != null
          ? DestinationModel.fromJson(json['destination'])
          : null,
      commodity: json['commodity'] != null
          ? CommodityModel.fromJson(json['commodity'])
          : null,
      billing: json['billing'] != null
          ? BillingModel.fromJson(json['billing'])
          : null,
      doDetails: (json['do_details'] as List?)
          ?.map((e) => DoDetailModel.fromJson(e))
          .toList(),
    );
  }
}
