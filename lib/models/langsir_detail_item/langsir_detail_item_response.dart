import 'package:newbkmmobile/core/R/json_safe.dart';
import 'package:newbkmmobile/models/langsir_detail_item/langsir_detail_item_data.dart';

class LangsirDetailItemResponse {
  final String? status;
  final LangsirDetailItemData? data;

  LangsirDetailItemResponse({
    this.status,
    this.data,
  });

  factory LangsirDetailItemResponse.fromJson(Map<String, dynamic> json) {
    return LangsirDetailItemResponse(
      status: safeString(json['status']),
      data: safeParse(
        json['data'],
            (e) => LangsirDetailItemData.fromJson(e),
      ),
    );
  }
}
