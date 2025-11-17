import 'package:newbkmmobile/models/do_connect_resp.dart';

class HistoryDetailResp {
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
  String? vehicleNumber;
  String? bonus;
  String? trvlExpenses;
  String? qrcode;
  String? spb;

  HistoryDetailResp({
    this.id,
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
    this.vehicleNumber,
    this.bonus,
    this.trvlExpenses,
    this.qrcode,
    this.spb,
  });

  HistoryDetailResp.fromJson(Map<String, dynamic> json) {
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
    vehicleNumber = json['vehicle_number'];
    bonus = json['bonus'];
    trvlExpenses = json['trvl_expenses'];
    qrcode = json['qrcode'];
    spb = json['spb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    if (doConnect != null) {
      data['do_connect'] = doConnect!.toJson();
    }
    data['sub_do'] = subDo;
    data['spb_number'] = spbNumber;
    data['do_number'] = doNumber;
    data['load_date'] = loadDate;
    data['unload_date'] = unloadDate;
    data['driver_id'] = driverId;
    data['driver_name'] = driverName;
    data['pks_name'] = pksName;
    data['destination_name'] = destinationName;
    data['amount_sent'] = amountSent;
    data['amount_received'] = amountReceived;
    data['commodity_name'] = commodityName;
    data['vehicle_number'] = vehicleNumber;
    data['bonus'] = bonus;
    data['trvl_expenses'] = trvlExpenses;
    data['qrcode'] = qrcode;
    data['spb'] = spb;

    return data;
  }
}
