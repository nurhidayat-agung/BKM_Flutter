import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/models/trip/list_new_do_response.dart';

class TripTimeline extends StatelessWidget {
  final List<AppLog> logs;

  const TripTimeline({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const Text(
        "Belum ada aktivitas.",
        style: TextStyle(color: Colors.black54),
      );
    }

    DateTime parseDate(String? dateStr) {
      if (dateStr == null) return DateTime.fromMillisecondsSinceEpoch(0);
      return DateTime.tryParse(dateStr) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }

    // Sort berdasarkan status.sort lalu created_at
    final sorted = [...logs]
      ..sort((a, b) {
        final s1 = a.status?.sort ?? 0;
        final s2 = b.status?.sort ?? 0;

        if (s1 != s2) return s1.compareTo(s2);

        final d1 = parseDate(a.createdAt);
        final d2 = parseDate(b.createdAt);

        return d2.compareTo(d1); // descending
      });


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Timeline Aktivitas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),

        ...sorted.map((log) => _TimelineItem(log)).toList(),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final AppLog log;

  const _TimelineItem(this.log);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bullet
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),

        // Text info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                log.status?.name ?? "-",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                log.createdAt != null
                    ? log.createdAt.toString()
                    : '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              if ((log.note ?? "").isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6),
                  child: Text(
                    log.note!,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
