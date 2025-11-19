import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/models/new_trip/delivery_response.dart';
import 'package:newbkmmobile/ui/pages/trip/time_line/time_line_item.dart';

List<Widget> buildTimeline(List<AppLog> logs) {
  return List.generate(logs.length, (i) {
    final log = logs[i];
    final isLast = i == logs.length - 1;

    final map = getStatusStyle(log.status?.fieldValue ?? '');

    return TimelineItem(
      title: log.status?.code ?? 'Unknown',
      description: log.status?.name ?? '',
      time: log.createdAt != null 
          ? log.createdAt.toString() : '',
      icon: map.icon,
      color: map.color,
      isLast: isLast,
    );
  });
}


class StatusStyle {
  final IconData icon;
  final Color color;

  StatusStyle(this.icon, this.color);
}

StatusStyle getStatusStyle(String status) {
  switch (status.toLowerCase()) {
    case 'created':
      return StatusStyle(Icons.edit, Colors.blue);
    case 'assigned':
      return StatusStyle(Icons.person, Colors.teal);
    case 'on_the_way':
      return StatusStyle(Icons.local_shipping, Colors.orange);
    case 'delivered':
      return StatusStyle(Icons.check_circle, Colors.green);
    case 'failed':
      return StatusStyle(Icons.error, Colors.red);
    default:
      return StatusStyle(Icons.info, Colors.grey);
  }
}
