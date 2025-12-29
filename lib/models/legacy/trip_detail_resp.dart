import 'package:newbkmmobile/models/legacy/do_connect_resp.dart';

class TripDetailResp {
  String? id;
  DoConnectResp? doConnect;
  String? subDo;
  String? spbNumber;
  String? doNumber;
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
  String? qrcode;
  String? spb;
  List<ListStatusTrip>? listStatusTrip;

  TripDetailResp(
      {this.id,
        this.doConnect,
        this.subDo,
        this.spbNumber,
        this.doNumber,
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
        this.statusTrip,
        this.qrcode,
        this.spb,
        this.listStatusTrip});

  TripDetailResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doConnect = json['do_connect'] != null
        ? DoConnectResp.fromJson(json['do_connect'])
        : null;
    subDo = json['sub_do'];
    spbNumber = json['spb_number'];
    doNumber = json['do_number'];
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
    qrcode = json['qrcode'];
    spb = json['spb'];
    if (json['list_status_trip'] != null) {
      listStatusTrip = <ListStatusTrip>[];
      json['list_status_trip'].forEach((v) {
        listStatusTrip!.add(new ListStatusTrip.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.doConnect != null) {
      data['do_connect'] = this.doConnect!.toJson();
    }
    data['sub_do'] = this.subDo;
    data['spb_number'] = this.spbNumber;
    data['do_number'] = this.doNumber;
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
    data['qrcode'] = this.qrcode;
    data['spb'] = this.spb;
    if (this.listStatusTrip != null) {
      data['list_status_trip'] =
          this.listStatusTrip!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListStatusTrip {
  String? id;
  String? shortName;
  String? longName;

  ListStatusTrip({this.id, this.shortName, this.longName});

  ListStatusTrip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortName = json['short_name'];
    longName = json['long_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['short_name'] = this.shortName;
    data['long_name'] = this.longName;
    return data;
  }
}