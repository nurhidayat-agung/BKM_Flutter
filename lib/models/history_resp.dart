import 'package:newbkmmobile/models/do_connect_resp.dart';

class HistoryResp {
  String? id;
  DoConnectResp? doConnect;
  String? doNumber;
  String? subDo;
  String? spbNumber;
  String? loadDate;
  String? unloadDate;
  String? driverId;
  String? pksName;
  String? destinationName;
  String? commodityName;
  String? bonus;

  HistoryResp(
      {this.id,
        this.doConnect,
        this.doNumber,
        this.subDo,
        this.spbNumber,
        this.loadDate,
        this.unloadDate,
        this.driverId,
        this.pksName,
        this.destinationName,
        this.commodityName,
        this.bonus});

  HistoryResp.fromJson(Map<String, dynamic> json) {
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
    pksName = json['pks_name'];
    destinationName = json['destination_name'];
    commodityName = json['commodity_name'];
    bonus = json['bonus'];
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
    data['pks_name'] = this.pksName;
    data['destination_name'] = this.destinationName;
    data['commodity_name'] = this.commodityName;
    data['bonus'] = this.bonus;
    return data;
  }
}