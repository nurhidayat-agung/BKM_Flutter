import 'package:newbkmmobile/models/langsir_detail/local_hauling_detail_data.dart';

class LocalHaulingDetailResponse {
  final String? status;
  final LocalHaulingDetailData? data;

  LocalHaulingDetailResponse({
    this.status,
    this.data,
  });

  factory LocalHaulingDetailResponse.fromJson(Map<String, dynamic> json) {
    return LocalHaulingDetailResponse(
      status: json['status'],
      data: json['data'] != null
          ? LocalHaulingDetailData.fromJson(json['data'])
          : null,
    );
  }
}
