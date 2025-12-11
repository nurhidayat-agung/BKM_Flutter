import 'package:newbkmmobile/models/common/app_setting_data.dart';

class AppSettingsResponse {
  String? status;
  AppSettingsData? data;

  AppSettingsResponse({this.status, this.data});

  factory AppSettingsResponse.fromJson(Map<String, dynamic> json) {
    return AppSettingsResponse(
      status: json['status'],
      data: json['data'] != null ? AppSettingsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.toJson(),
  };
}
