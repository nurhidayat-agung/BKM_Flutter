import 'package:newbkmmobile/models/legacy/data_resp.dart';
import 'package:newbkmmobile/models/legacy/msg_resp.dart';

class DebugResp {
  MsgResp? msg;
  DataResp? data;

  DebugResp(
      {this.msg,
        this.data});

  DebugResp.fromJson(Map<String, dynamic> json) {
    msg = json['msg'] != null
        ? MsgResp.fromJson(json['msg'])
        : null;
    data = json['data'] != null
        ? DataResp.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msg != null) {
      data['msg'] = this.msg!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}