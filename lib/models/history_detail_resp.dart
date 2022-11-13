class HistoryDetailResp {
  String? id;
  String? doConnect;
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

  HistoryDetailResp(
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
        this.vehicleNumber,
        this.bonus,
        this.trvlExpenses,
        this.qrcode,
        this.spb});

  HistoryDetailResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doConnect = json['do_connect'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['do_connect'] = this.doConnect;
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
    data['vehicle_number'] = this.vehicleNumber;
    data['bonus'] = this.bonus;
    data['trvl_expenses'] = this.trvlExpenses;
    data['qrcode'] = this.qrcode;
    data['spb'] = this.spb;
    return data;
  }
}