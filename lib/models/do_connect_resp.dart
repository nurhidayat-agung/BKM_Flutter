class DoConnectResp {
  String? id;
  String? subDo;
  String? doNumber;
  String? amountSent;
  String? amountReceived;
  String? loadDate;
  String? unloadDate;

  DoConnectResp(
      {this.id,
        this.subDo,
        this.doNumber,
        this.amountSent,
        this.amountReceived,
        this.loadDate,
        this.unloadDate});

  DoConnectResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subDo = json['sub_do'];
    doNumber = json['do_number'];
    amountSent = json['amount_sent'];
    amountReceived = json['amount_received'];
    loadDate = json['load_date'];
    unloadDate = json['unload_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_do'] = this.subDo;
    data['do_number'] = this.doNumber;
    data['amount_sent'] = this.amountSent;
    data['amount_received'] = this.amountReceived;
    data['load_date'] = this.loadDate;
    data['unload_date'] = this.unloadDate;
    return data;
  }
}