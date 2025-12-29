import 'package:newbkmmobile/models/legacy/do_connect_resp.dart';

class TripResp {
  String? id;
  DoConnectResp? doConnect;
  String? doNumber;
  String? subDo;
  String? spbNumber;
  String? loadDate;
  String? unloadDate;
  String? driverId;
  String? driverName;
  String? pksName;
  String? destinationName;
  String? amountSent;
  String? amountReceived;
  String? commodityName;
  String? trvlExpenses;
  String? vehicleNumber;
  String? status;
  String? statusTrip;

  TripResp(
      {this.id,
        this.doConnect,
        this.doNumber,
        this.subDo,
        this.spbNumber,
        this.loadDate,
        this.unloadDate,
        this.driverId,
        this.driverName,
        this.pksName,
        this.destinationName,
        this.amountSent,
        this.amountReceived,
        this.commodityName,
        this.trvlExpenses,
        this.vehicleNumber,
        this.status,
        this.statusTrip});

  TripResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doConnect = json['do_connect'] != null
        ? DoConnectResp.fromJson(json['do_connect'])
        : null;
    doNumber = json['do_number'];
    subDo = json['sub_do'];
    spbNumber = json['spb_number'];
    loadDate = json['load_date'];
    unloadDate = json['unload_date'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    pksName = json['pks_name'];
    destinationName = json['destination_name'];
    amountSent = json['amount_sent'];
    amountReceived = json['amount_received'];
    commodityName = json['commodity_name'];
    trvlExpenses = json['trvl_expenses'];
    vehicleNumber = json['vehicle_number'];
    status = json['status'];
    statusTrip = json['status_trip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.doConnect != null) {
      data['do_connect'] = this.doConnect!.toJson();
    }
    data['do_number'] = this.doNumber;
    data['sub_do'] = this.subDo;
    data['spb_number'] = this.spbNumber;
    data['load_date'] = this.loadDate;
    data['unload_date'] = this.unloadDate;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['pks_name'] = this.pksName;
    data['destination_name'] = this.destinationName;
    data['amount_sent'] = this.amountSent;
    data['amount_received'] = this.amountReceived;
    data['commodity_name'] = this.commodityName;
    data['trvl_expenses'] = this.trvlExpenses;
    data['vehicle_number'] = this.vehicleNumber;
    data['status'] = this.status;
    data['status_trip'] = this.statusTrip;
    return data;
  }
}