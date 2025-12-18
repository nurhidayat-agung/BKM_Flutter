import 'package:newbkmmobile/models/langsir_detail/driver_model.dart';
import 'package:newbkmmobile/models/langsir_detail/status_model.dart';
import 'package:newbkmmobile/models/langsir_detail/vehicle_model.dart';

class DoDetailModel {
  final String? id;
  final int? doNumber;
  final int? loadQuantity;
  final int? unloadQuantity;
  final String? loadDate;
  final String? unloadDate;
  final String? note;

  final StatusModel? status;
  final DriverModel? driver;
  final VehicleModel? vehicle;

  DoDetailModel({
    this.id,
    this.doNumber,
    this.loadQuantity,
    this.unloadQuantity,
    this.loadDate,
    this.unloadDate,
    this.note,
    this.status,
    this.driver,
    this.vehicle,
  });

  factory DoDetailModel.fromJson(Map<String, dynamic> json) {
    return DoDetailModel(
      id: json['id'],
      doNumber: json['do_number'],
      loadQuantity: json['load_quantity'],
      unloadQuantity: json['unload_quantity'],
      loadDate: json['load_date'],
      unloadDate: json['unload_date'],
      note: json['note'],
      status:
      json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      driver:
      json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      vehicle: json['vehicle'] != null
          ? VehicleModel.fromJson(json['vehicle'])
          : null,
    );
  }
}
