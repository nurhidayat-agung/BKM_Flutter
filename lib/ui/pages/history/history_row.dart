import 'package:flutter/material.dart';
import 'package:newbkmmobile/models/trip_history/delivery_detail_history.dart';
import 'package:newbkmmobile/models/trip_history/v2/do_detail_history.dart';
import 'package:newbkmmobile/ui/pages/history/history_detail_page.dart';

class HistoryRow extends StatelessWidget {
  final int index;
  final DoDetailHistory historyResp;
  final DoDetailHistory historyRespBefore;

  const HistoryRow({
    super.key,
    required this.index,
    required this.historyResp,
    required this.historyRespBefore,
  });

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      const months = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Des"];
      return "${dt.day} ${months[dt.month - 1]} ${dt.year}";
    } catch (_) {
      return "-";
    }
  }
  

  @override
  Widget build(BuildContext context) {
    /// sementara hardcode karena struktur detail belum final
    final date = _formatDate("2025-11-11");

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HistoryDetailPage(id: historyResp.id ?? "", detailHistory: historyResp,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DO NUMBER + DATE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  historyResp.deliveryOrder?.doNumber ?? "",  // dummy
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF002B4C),
                  ),
                ),
                Text(
                  _formatDate(historyResp.createdAt ?? ""), // dummy formatted
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF8D8D8D),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2),

            /// ROUTE + COMMODITY
            Text(
              "${historyResp.deliveryOrder?.pks?.code} → ${historyResp.deliveryOrder?.destination?.code} | ${historyResp.deliveryOrder?.commodity?.name}", // dummy
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFFD4552F),
              ),
            ),

            const SizedBox(height: 10),

            /// Divider
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFFE6E6E6),
            ),
          ],
        ),
      ),
    );
  }
}
