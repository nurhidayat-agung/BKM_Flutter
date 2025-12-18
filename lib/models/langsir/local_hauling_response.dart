import 'package:newbkmmobile/models/langsir/local_hauling_data.dart';

class LocalHaulingResponse {
  final String? status;
  final List<LocalHaulingData>? data;

  LocalHaulingResponse({
    this.status,
    this.data,
  });

  factory LocalHaulingResponse.fromJson(Map<String, dynamic> json) {
    return LocalHaulingResponse(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => LocalHaulingData.fromJson(e))
          .toList(),
    );
  }
}
