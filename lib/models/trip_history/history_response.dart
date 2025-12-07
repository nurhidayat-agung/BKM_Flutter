import 'package:newbkmmobile/models/trip_history/delivery_detail_history.dart';
import 'package:newbkmmobile/models/trip_history/v2/do_detail_history.dart';

class HistoryResponse {
  final List<DoDetailHistory> data;
  final String message;

  HistoryResponse({
    required this.data,
    required this.message,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      data: json['data'] != null
          ? List<DoDetailHistory>.from(
        json['data'].map((x) => DoDetailHistory.fromJson(x)),
      )
          : [],
      message: json['message'] ?? '',
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "data": data.map((e) => e.toJson()).toList(),
  //     "message": message,
  //   };
  // }
}
