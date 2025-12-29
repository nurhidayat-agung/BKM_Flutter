import 'package:newbkmmobile/core/R/json_safe.dart';
import 'package:newbkmmobile/models/langsir_detail/driver_model.dart';
import 'package:newbkmmobile/models/langsir_detail/status_model.dart';
import 'package:newbkmmobile/models/langsir_detail/vehicle_model.dart';
import 'package:newbkmmobile/models/langsir_detail_item/delivery_order_model.dart';
import 'package:newbkmmobile/models/langsir_detail_item/file_model.dart';

class LangsirDetailItemData {
  final String? id;
  final String? doId;
  final String? vehicleId;
  final String? driverId;
  final int? doNumber;

  final int? loadQuantity;
  final int? unloadQuantity;
  final String? loadDate;
  final String? unloadDate;

  final String? spbNumber;
  final int? shippingCost;
  final bool? isActive;

  final StatusModel? status;
  final DeliveryOrderModel? deliveryOrder;
  final DriverModel? driver;
  final VehicleModel? vehicle;
  final List<FileModel>? files;

  LangsirDetailItemData({
    this.id,
    this.doId,
    this.vehicleId,
    this.driverId,
    this.doNumber,
    this.loadQuantity,
    this.unloadQuantity,
    this.loadDate,
    this.unloadDate,
    this.spbNumber,
    this.shippingCost,
    this.isActive,
    this.status,
    this.deliveryOrder,
    this.driver,
    this.vehicle,
    this.files,
  });

  factory LangsirDetailItemData.fromJson(Map<String, dynamic> json) {
    return LangsirDetailItemData(
      id: safeString(json['id']),
      doId: safeString(json['do_id']),
      vehicleId: safeString(json['vehicle_id']),
      driverId: safeString(json['driver_id']),
      doNumber: safeInt(json['do_number']),
      loadQuantity: safeInt(json['load_quantity']),
      unloadQuantity: safeInt(json['unload_quantity']),
      loadDate: safeString(json['load_date']),
      unloadDate: safeString(json['unload_date']),
      spbNumber: safeString(json['spb_number']),
      shippingCost: safeInt(json['shipping_cost']),
      isActive: safeBool(json['is_active']),
      status: safeParse(json['status'], (e) => StatusModel.fromJson(e)),
      deliveryOrder: safeParse(
        json['delivery_order'],
            (e) => DeliveryOrderModel.fromJson(e),
      ),
      driver: safeParse(json['driver'], (e) => DriverModel.fromJson(e)),
      vehicle: safeParse(json['vehicle'], (e) => VehicleModel.fromJson(e)),
      files: safeList(json['files'])
          ?.map((e) => safeParse(e, (v) => FileModel.fromJson(v)))
          .whereType<FileModel>()
          .toList(),
    );
  }
}
