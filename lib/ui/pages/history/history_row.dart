import 'package:flutter/material.dart';
import 'package:newbkmmobile/models/history_resp.dart';
import 'package:newbkmmobile/ui/pages/history/history_detail_page.dart';

class HistoryRow extends StatelessWidget {
  final int index;
  final HistoryResp historyResp;
  final HistoryResp historyRespBefore;

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
    final date = _formatDate(historyResp.loadDate ?? "");

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HistoryDetailPage(id: historyResp.id ?? "")),
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
                  historyResp.doNumber ?? "-",
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF002B4C),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF8D8D8D),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2),

            /// ROUTE + COMMODITY
            Text(
              "${historyResp.pksName ?? '-'} → ${historyResp.destinationName ?? '-'} | ${historyResp.commodityName ?? '-'}",
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFFD4552F),
              ),
            ),

            const SizedBox(height: 10),

            /// Divider Mockup
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
