import 'package:newbkmmobile/models/legacy/do_connect_resp.dart';

class HistoryResp {
  String? id;
  DoConnectResp? doConnect;
  String? doNumber;
  String? subDo;
  String? spbNumber;
  String? loadDate;
  String? unloadDate;
  String? driverId;

  // Tambahan untuk tampilan list & compatibility
  String? driverName;
  String? vehicleNumber;

  // field untuk Langsir
  String? type; // "LANGSIR" / "NORMAL"

  String? pksName;
  String? destinationName;
  String? commodityName;
  String? bonus;

  HistoryResp({
    this.id,
    this.doConnect,
    this.doNumber,
    this.subDo,
    this.spbNumber,
    this.loadDate,
    this.unloadDate,
    this.driverId,
    this.driverName,
    this.vehicleNumber,
    this.type,
    this.pksName,
    this.destinationName,
    this.commodityName,
    this.bonus,
  });

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

    driverName = json['driver_name'];
    vehicleNumber = json['vehicle_number'];
    type = json['type'];

    pksName = json['pks_name'];
    destinationName = json['destination_name'];
    commodityName = json['commodity_name'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    if (doConnect != null) {
      data['do_connect'] = doConnect!.toJson();
    }
    data['do_number'] = doNumber;
    data['sub_do'] = subDo;
    data['spb_number'] = spbNumber;
    data['load_date'] = loadDate;
    data['unload_date'] = unloadDate;
    data['driver_id'] = driverId;

    data['driver_name'] = driverName;
    data['vehicle_number'] = vehicleNumber;
    data['type'] = type;

    data['pks_name'] = pksName;
    data['destination_name'] = destinationName;
    data['commodity_name'] = commodityName;
    data['bonus'] = bonus;

    return data;
  }
}

