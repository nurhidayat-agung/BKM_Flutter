class DataResp {
  String? id;
  String? statusTrip;
  String? loadDate;
  String? unloadDate;
  String? spbNumber;
  String? amountSent;
  String? amountReceived;
  String? domasterId;
  String? trigger;
  String? spbId;
  String? status;

  DataResp(
      {this.id,
        this.statusTrip,
        this.loadDate,
        this.unloadDate,
        this.spbNumber,
        this.amountSent,
        this.amountReceived,
        this.domasterId,
        this.trigger,
        this.spbId,
        this.status});

  DataResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusTrip = json['status_trip'];
    loadDate = json['load_date'];
    unloadDate = json['unload_date'];
    spbNumber = json['spb_number'];
    amountSent = json['amount_sent'];
    amountReceived = json['amount_received'];
    domasterId = json['domaster_id'];
    trigger = json['trigger'];
    spbId = json['spb_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_trip'] = this.statusTrip;
    data['load_date'] = this.loadDate;
    data['unload_date'] = this.unloadDate;
    data['spb_number'] = this.spbNumber;
    data['amount_sent'] = this.amountSent;
    data['amount_received'] = this.amountReceived;
    data['domaster_id'] = this.domasterId;
    data['trigger'] = this.trigger;
    data['spb_id'] = this.spbId;
    data['status'] = this.status;
    return data;
  }
}