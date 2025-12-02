import 'package:newbkmmobile/models/trip_history/delivery_detail_history.dart';

class HistoryResponse {
  final List<DeliveryDetailHistory> data;
  final String message;

  HistoryResponse({
    required this.data,
    required this.message,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      data: json['data'] != null
          ? List<DeliveryDetailHistory>.from(
        json['data'].map((x) => DeliveryDetailHistory.fromJson(x)),
      )
          : [],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data.map((e) => e.toJson()).toList(),
      "message": message,
    };
  }
}
