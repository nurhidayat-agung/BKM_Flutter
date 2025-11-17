import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/history_resp.dart';
import 'package:newbkmmobile/ui/pages/history/history_detail_page.dart';

class HistoryRow extends StatefulWidget {
  const HistoryRow({
    Key? key,
    required this.index,
    required this.historyResp,
    required this.historyRespBefore,
  }) : super(key: key);

  final int index;
  final HistoryResp historyResp;
  final HistoryResp historyRespBefore;

  @override
  State<HistoryRow> createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {
  final _convertDate = ConvertDate();

  String _formatShortDate(String raw) {
    if (raw.isEmpty) return "-";
    try {
      final dt = DateTime.parse(raw);
      const months = [
        "Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
        "Jul", "Agu", "Sep", "Okt", "Nov", "Des"
      ];
      return "${dt.day} ${months[dt.month - 1]} ${dt.year}";
    } catch (_) {
      return raw;
    }
  }

  // handle gabungan DO string
  String _getAllDoNumber() {
    if (widget.historyResp.doConnect != null) {
      try {
        var id1 = int.parse(widget.historyResp.id ?? "0");
        var id2 = int.parse(widget.historyResp.doConnect?.id ?? "0");
        if (id1 > id2) {
          return "${widget.historyResp.doConnect?.doNumber?.substring(0, 4)} & ${widget.historyResp.doNumber ?? ""}";
        } else {
          return "${widget.historyResp.doNumber?.substring(0, 4)} & ${widget.historyResp.doConnect?.doNumber ?? ""}";
        }
      } catch (e) {
        return widget.historyResp.doNumber ?? "";
      }
    } else {
      return widget.historyResp.doNumber ?? "";
    }
  }

  bool _isLangsir() {
    // menampilkan "Langsir"
    final comm = (widget.historyResp.commodityName ?? "").toLowerCase();
    final pks = (widget.historyResp.pksName ?? "").toLowerCase();
    final doNum = (widget.historyResp.doNumber ?? "").toLowerCase();
    if (comm.contains('langsir') || pks.contains('langsir') || doNum.contains('langsir')) {
      return true;
    }
    // Destinasi langsir
    final dest = (widget.historyResp.destinationName ?? "").toLowerCase();
    if (dest.contains('langsir')) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final pks = widget.historyResp.pksName ?? "-";
    final dest = widget.historyResp.destinationName ?? "-";
    final comm = widget.historyResp.commodityName ?? "-";
    final doNumber = _getAllDoNumber();
    final dateShow = widget.historyResp.loadDate ?? widget.historyResp.unloadDate ?? "";

    //Langsir badge
    final isLangsir = _isLangsir();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // bulan
          Visibility(
            visible: widget.index == 0 ||
                _convertDate.convertToMMMMyyyy(widget.historyResp.loadDate ?? "") !=
                    _convertDate.convertToMMMMyyyy(widget.historyRespBefore.loadDate ?? ""),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 6.0, bottom: 6.0),
              child: Text(
                _convertDate.convertToMMMMyyyy(widget.historyResp.loadDate ?? ""),
                style: TextStyle(
                  color: R.colors.colorText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Card
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => HistoryDetailPage(id: widget.historyResp.id ?? ""),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "$pks → $dest",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // commodity
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            comm,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),

                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Nomer DO
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            doNumber,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: R.colors.colorPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Langsir
                        if (isLangsir)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: R.colors.colorPrimary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: R.colors.colorPrimary.withOpacity(0.2)),
                            ),
                            child: Text(
                              "Langsir",
                              style: TextStyle(
                                color: R.colors.colorPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // short date at bottom (grey)
                    Text(
                      _formatShortDate(dateShow),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

